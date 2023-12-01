module rele(reset_in, clock_in, numgiro_in, contador_giro_out, sensor1_in, sensor2_in, rele_out);

// input
input reset_in, clock_in;
input wire sensor1_in, sensor2_in;
input wire [3:0] numgiro_in;

// output
output wire rele_out;
output wire [3:0] contador_giro_out;

// reg
reg girar;
reg [3:0] contador_giro;
reg [3:0] debounce_sensores;
reg espera_sensores;

// logica do rele
always @(posedge clock_in or posedge reset_in) begin
// reset dos reg
if(reset_in) begin
 girar = 1'b0;
 contador_giro = 4'b0000;
 debounce_sensores = 4'b0000;
 espera_sensores = 1'b1;
end
else begin
 
 // caso tenha uma tecla definida ativa o giro
 if(numgiro_in > 4'b0000 && girar == 1'b0)begin
  contador_giro = numgiro_in;
  girar = 1'b1;
 end
 
 // verifica se terminou de girar
 if(sensor1_in == 1'b1 && sensor2_in == 1'b1) begin
  if(espera_sensores == 1'b0) begin
   debounce_sensores = debounce_sensores + 4'b0001;
  end
 end
 else if(sensor1_in != 1'b1 && sensor2_in != 1'b1) begin
  debounce_sensores = 4'b0000;
  espera_sensores = 1'b0;
 end
 else begin
  debounce_sensores = 4'b0000;
 end
 
 // diminui o valor de num giro
 if(debounce_sensores == 4'b1111) begin
 
  debounce_sensores = 4'b0000;
  
  if(contador_giro != 4'b0000 && espera_sensores == 1'b0)begin
  
    contador_giro = contador_giro - 4'b0001;
    espera_sensores = 1'b1;
	 
	 // define a variavel girar
	 if(contador_giro == 4'b0000)begin
     girar = 1'b0;
    end
    else begin
     girar = 1'b1;
    end
	 
  end
 end
 
end
end

// girar + !s1*!s2
assign rele_out = girar | (!sensor1_in & !sensor2_in);

assign contador_giro_out = contador_giro;

endmodule
