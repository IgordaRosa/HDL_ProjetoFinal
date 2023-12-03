module vendingmachine 
(
 reset_in, 
 clock_in, 
 coluna_in, 
 linha_in, 
 sensor1_in, 
 sensor2_in, 
 rele_out,
 seg_out
 );

// input
input wire [2:0] coluna_in, linha_in;
input wire sensor1_in, sensor2_in;
input clock_in, reset_in;

// output
output wire rele_out;
output [6:0] seg_out;

// wire
wire [3:0] numgiro_w, contador_giro_w;
//wire [6:0] seg_out_w;

teclado T0
(
 .clock_in(clock_in),
 .reset_in(reset_in),
 .coluna_in(coluna_in),
 .linha_in(linha_in),
 .numgiro_out(numgiro_w)
);

rele R0
(
 .clock_in(clock_in),
 .reset_in(reset_in),
 .numgiro_in(numgiro_w),
 .contador_giro_out(contador_giro_w),
 .sensor1_in(sensor1_in),
 .sensor2_in(sensor2_in),
 .rele_out(rele_out)
);

display7seg D0
(
 .clock_in(clock_in),
 .reset_in(reset_in),
 .numgiro_in(contador_giro_w),
 .seg_out(seg_out)
);

endmodule
