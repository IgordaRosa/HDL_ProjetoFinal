module vendingmachine(reset_in, clock_in, 
							 coluna_in, linha_in, sensor1_in, sensor2_in, rele_out,
							 lcd_out, enlcd_out, rslcd_out, rwlcd_out);

input wire [2:0] coluna_in;
input wire [3:0] linha_in;
input wire sensor1_in, sensor2_in;
input clock_in, reset_in;
output wire rele_out;

// variaveis reg
reg girar;
reg [3:0] contador;
reg [3:0] contadorSensores;
reg NumGiro;
reg [6:0] BackupTecla;
reg esperar;
reg acionamentoSensores;

// lcd
output [7:0] lcd_out;
output enlcd_out;
output rslcd_out;
output rwlcd_out;
// Definir parâmetros do display
localparam NUM_ROWS = 2;
localparam NUM_COLS = 16;
// Declaração de sinais internos
reg [3:0] state;
reg [5:0] row;
reg [5:0] col;
reg [7:0] display_ram[NUM_ROWS * NUM_COLS - 1:0];
reg [7:0] NumGiroConv;

always @(posedge clock_in or posedge reset_in)begin
 if(reset_in)begin
  NumGiro = 4'b0000;
  contador = 4'b0000;
  girar = 1'b0;
  BackupTecla = 8'b0;
  esperar = 1'b0;
  acionamentoSensores = 1'b0;
 end
 else begin
  if(esperar == 1'b0)begin
   if(contador == 4'b1111)begin
   // define o valor de numGiro para qual tecla do teclado matricial foi pressionada.
    if(linha_in == 4'b0001)begin
    // codigo para deletar do display e confimar, 0 reseta o numero.
	
    end
    else if(coluna_in == 3'b100) begin
     NumGiro = 4'b0001;
	 end
    else if(coluna_in == 3'b010) begin
     NumGiro = 4'b0010;
	 end
    else if(coluna_in == 3'b001) begin
     NumGiro = 4'b0011;
	 end

    if(linha_in == 4'b0001 || linha_in == 4'b1000) begin
    // não faz nada, só pra n cair na adição da linha caso esteja selecionando operação ou seja a primeira linha.
	 end
    else if(linha_in == 4'b0100) begin
     NumGiro = NumGiro + 4'b0011;
	 end
    else if(linha_in == 4'b0010) begin
     NumGiro = NumGiro + 4'b0110;
	 end
   end // if(contador == 4'b1111)begin
  end // if(esperar == 1'b0)begin
 
 if(NumGiro != 4'b0000)begin
  girar = 1'b0;
 end
 else begin
  girar = 1'b1;
  esperar = 1'b1;
 end
 
 if(BackupTecla == {coluna_in, linha_in})begin
  contador = contador + 4'b0001;
 end
 else begin
  contador = 4'b0000;
  BackupTecla = {coluna_in, linha_in};
 end
 
 if(sensor1_in == 1'b1 && sensor2_in == 1'b1)begin
  contadorSensores = contadorSensores + 4'b0001;
 end
 else begin
  contadorSensores = 4'b0000;
  acionamentoSensores = 1'b0;
 end
 
 if(contadorSensores == 4'b1111)begin
   contadorSensores = 4'b0000;
   if(NumGiro != 4'b0000)begin
	 if(acionamentoSensores == 1'b0)begin 
	  NumGiro = NumGiro - 4'b0001;
	  acionamentoSensores = 1'b1;
	 end
   end
   else begin
	 esperar = 1'b0;
    girar = 1'b0;
   end
  end // if(contadorSensores == 4'b1111)begin
 end // else do reset
end // always

// F(ABC)=	girar	+ s1*s2: por que s1 e s2 são invertidos
assign rele_out = girar | (sensor1_in & sensor2_in);

always @(posedge clock_in or posedge reset_in)begin
	case (NumGiro)
	 4'b0000: NumGiroConv = 8'b00110000; // '0' em ASCII
	 4'b0001: NumGiroConv = 8'b00110001; // '1' em ASCII
	 4'b0010: NumGiroConv = 8'b00110010; // '2' em ASCII
	 4'b0011: NumGiroConv = 8'b00110011; // '3' em ASCII
	 4'b0100: NumGiroConv = 8'b00110100; // '4' em ASCII
	 4'b0101: NumGiroConv = 8'b00110101; // '5' em ASCII
	 4'b0110: NumGiroConv = 8'b00110110; // '6' em ASCII
	 4'b0111: NumGiroConv = 8'b00110111; // '7' em ASCII
	 4'b1000: NumGiroConv = 8'b00111000; // '8' em ASCII
	 4'b1001: NumGiroConv = 8'b00111001; // '9' em ASCII
	 default: NumGiroConv = 8'b00110000; // Se não for um dígito, mostre '0'
	endcase
	
	if (reset_in) begin
		row <= 6'b0;
		col <= 6'b0;
	end
	else if (enlcd_out) begin
		display_ram[row * NUM_COLS + col] <= NumGiroConv;
		col <= col + 1;
		if (col == NUM_COLS) begin
			col <= 6'b0;
			row <= row + 1;
			if (row == NUM_ROWS) begin
				row <= 6'b0;
			end
		end
  end
  
end

assign rslcd_out = 1'b1;  // Modo de dados
assign rwlcd_out = 1'b0;  // Leitura/gravação

endmodule
