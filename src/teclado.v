module teclado(reset_in, clock_in, coluna_in, linha_in, numgiro_out);

// input
input reset_in, clock_in;
input wire [2:0] coluna_in, linha_in;

// output
output [3:0] numgiro_out;

// reg
reg [3:0] backup_numgiro, contador;
reg [5:0] backup_tecla;

always @(posedge clock_in or posedge reset_in) begin
// caso aconteça um reset
 if(reset_in) begin
  backup_numgiro = 4'b0000;
  contador = 4'b0000;
  backup_tecla = 8'b0;
 end
// caso aconteça um pulso de clock
 else begin
  // logica para o teclado
  if(contador == 4'b1111)begin
	
   // define o valor de numGiro para qual tecla do teclado matricial foi pressionada.
	case(coluna_in)
	 3'b100: backup_numgiro = 4'b0001;
	 3'b010: backup_numgiro = 4'b0010;
	 3'b001: backup_numgiro = 4'b0011;
	 default: backup_numgiro = 4'b0000;
	endcase 
	case(linha_in)
	 3'b100: backup_numgiro = backup_numgiro;
	 3'b010: backup_numgiro = backup_numgiro + 4'b0011;
	 3'b001: backup_numgiro = backup_numgiro + 4'b0110;
	 default: backup_numgiro = 4'b0000;
	endcase
  end
	
  // debounce do teclado 
  if(backup_tecla == {coluna_in, linha_in})begin
   contador = contador + 4'b0001;
  end
  else begin
   contador = 4'b0000;
   backup_tecla = {coluna_in, linha_in};
  end
 end
end

// define a saida a partir da logica
assign numgiro_out = backup_numgiro;

endmodule
