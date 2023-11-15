module vendingmachine(
  input clk,
  input wire rst,
  input wire [3:0] Linha,
  input wire [3:0] Coluna,
  output wire rele,
  output reg [3:0] numero,
  input wire sensor1, 
  input wire sensor2
);
  reg [3:0] tecla_anterior;
  reg [3:0] tecla_atual;
  reg [7:0] debounce_count;
  reg [3:0] contador_sensor1;
  reg [3:0] contador_sensor2;
  reg [1:0] estado_sensor1;
  reg [1:0] estado_sensor2;
  
  parameter MAX_COUNT = 8'd10;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      tecla_anterior <= 4'b1111;
      tecla_atual <= 4'b1111;
      debounce_count <= 8'b0;
      numero <= 4'b0000;
		contador_sensor1 <= 4'b0000;
      contador_sensor2 <= 4'b0000;
      estado_sensor1 <= 2'b11;
      estado_sensor2 <= 2'b11;
    end else begin
      if (Linha == 4'b1111) begin
        tecla_anterior <= tecla_atual;
        tecla_atual <= Coluna;
      end
		
		if (sensor1 == estado_sensor1[0])
      contador_sensor1 <= 4'b0000;
      else if (contador_sensor1 < MAX_COUNT)
      contador_sensor1 <= contador_sensor1 + 1;
		
		estado_sensor1 <= {sensor1, estado_sensor1[0]};

		// Se o contador atingir MAX_COUNT, atualize o número
		if (contador_sensor1 == MAX_COUNT && estado_sensor1[1] == 1'b0)begin
       if(numero != 4'b0000)begin
		  numero <= numero - 4'b0001;
		 end
		end
		
		// Lógica para debouncing do sensor2
		if (sensor2 == estado_sensor2[0])
      contador_sensor2 <= 4'b0000;
		else if (contador_sensor2 < MAX_COUNT)
      contador_sensor2 <= contador_sensor2 + 1;
		estado_sensor2 <= {sensor2, estado_sensor2[0]};

		// Se o contador atingir MAX_COUNT, atualize o número
		if (contador_sensor2 == MAX_COUNT && estado_sensor2[1] == 1'b0)
      numero <= numero - 4'b0001;
		
      if (tecla_anterior != tecla_atual) begin
        debounce_count <= debounce_count + 1;
        if (debounce_count == 8'hFF) begin
          numero <= mapear_tecla(tecla_atual);
          debounce_count <= 8'b0;
        end
      end else begin
        debounce_count <= 8'b0;
      end
    end
  end
  
  
assign rele = ((numero != 4'b0000) || (sensor1 == 1'b0 && sensor2 == 1'b0)) ? 1'b1 : 1'b0;

  
  
  /*
  always @(posedge sensor1 or posedge sensor2)begin
	if(sensor1 == 1'b0 or sensor2 == 1'b0)begin
	 numero = numero - 4'b0001;
	end
  end*/

  function [3:0] mapear_tecla;
    input [3:0] coluna;
    case (coluna)
      4'b1110: mapear_tecla = 4'b0001; // Tecla 1
      4'b1101: mapear_tecla = 4'b0010; // Tecla 2
      4'b1011: mapear_tecla = 4'b0011; // Tecla 3
      4'b0111: mapear_tecla = 4'b0100; // Tecla 4
      default: mapear_tecla = 4'b0000; // Nenhuma tecla pressionada ou múltiplas teclas pressionadas
    endcase
  endfunction
endmodule
