module vendingmachine(reset_in, clock_in, coluna_in, linha_in, sensor1_in, sensor2_in, rele_out, lcd_out, enlcd_out, rslcd_out, rwlcd_out);

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

endmodule
