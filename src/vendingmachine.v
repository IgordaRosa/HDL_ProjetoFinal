module vendingmachine(reset, clock, coluna, linha, sensor1, sensor2,rele);
input wire [2:0] coluna;
input wire [3:0] linha;
input wire sensor1, sensor2;
input clock, reset;
output wire rele;
reg girar;
reg [3:0] contador;
reg [3:0] contadorSensores;
reg NumGiro;
reg [6:0] BackupTecla;
reg esperar;

always @(posedge clock or posedge reset)begin
 if(reset)begin
  NumGiro = 4'b0000;
  contador = 4'b0000;
  girar = 1'b0;
  BackupTecla = 8'b0;
  esperar = 1'b0;
 end
 else begin
  if(esperar == 1'b0)begin
   if(contador == 4'b1111)begin
   // define o valor de numGiro para qual tecla do teclado matricial foi pressionada.
    if(linha == 4'b0001)begin
    // codigo para deletar do display e confimar, 0 reseta o numero.
	
    end
    else if(coluna == 3'b100) begin
     NumGiro = 4'b0001;
	 end
    else if(coluna == 3'b010) begin
     NumGiro = 4'b0010;
	 end
    else if(coluna == 3'b001) begin
     NumGiro = 4'b0011;
	 end

    if(linha == 4'b0001 || linha == 4'b1000) begin
    // não faz nada, só pra n cair na adição da linha caso esteja selecionando operação ou seja a primeira linha.
	 end
    else if(linha == 4'b0100) begin
     NumGiro = NumGiro + 4'b0011;
	 end
    else if(linha == 4'b0010) begin
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
 
 if(BackupTecla == {coluna, linha})begin
  contador = contador + 4'b0001;
 end
 else begin
  contador = 4'b0000;
  BackupTecla = {coluna, linha};
 end
 
 if(sensor1 == 1'b1 && sensor2 == 1'b1)begin
  contadorSensores = contadorSensores + 4'b0001;
 end
 else begin
  contadorSensores = 4'b0000;
 end
 
 if(contadorSensores == 4'b1111)begin
   contadorSensores = 4'b0000;
   if(NumGiro != 4'b0000)begin
	 NumGiro = NumGiro - 4'b0001;
   end
   else begin
	 esperar = 1'b0;
    girar = 1'b0;
   end
  end // if(contadorSensores == 4'b1111)begin
 end // else do reset
end // always

// F(ABC)=	girar	+ s1*s2: por que s1 e s2 são invertidos
assign rele = girar | sensor1 & sensor2;

endmodule
