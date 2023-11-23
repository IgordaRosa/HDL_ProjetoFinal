`timescale 10us/100ns

module vendingmachine_tb;

reg [2:0] coluna_in_r;
reg [3:0] linha_in_r;
reg sensor1_in_r, sensor2_in_r;
reg clock_in_r, reset_in_r;
wire rele_out_w;

// lcd
wire [7:0] lcd_out_w;
wire enlcd_out_w;
wire rslcd_out_w;
wire rwlcd_out_w;

integer contador;

vendingmachine U0
(
  .coluna_in(coluna_in_r),
  .linha_in(linha_in_r),
  .sensor1_in(sensor1_in_r),
  .sensor2_in(sensor2_in_r),
  .clock_in(clock_in_r),
  .reset_in(reset_in_r),
  .rele_out(rele_out_w),
  .lcd_out(lcd_out_w),
  .enlcd_out(enlcd_out_w),
  .rslcd_out(rslcd_out_w),
  .rwlcd_out(rwlcd_out_w)
);

	
initial begin

contador = 0;
coluna_in_r = 3'b000;
linha_in_r = 4'b0000;
clock_in_r = 1'b0;
sensor1_in_r = 1'b1;
sensor2_in_r = 1'b1;


forever begin
#1;
clock_in_r = !clock_in_r;
contador = contador + 1;

if(contador == 1)begin
 reset_in_r = 1'b0;
end

if(contador == 10)begin
 reset_in_r = 1'b1;
end

if(contador == 1000)begin
 reset_in_r = 1'b0;
end

if(contador == 1100)begin
 coluna_in_r = 3'b010;
 linha_in_r = 4'b1000;
end

if(contador == 2100)begin
 coluna_in_r = 3'b000;
 linha_in_r = 4'b0000;
 sensor1_in_r = 1'b0;
 sensor2_in_r = 1'b0;
end

if(contador == 5100)begin
 coluna_in_r = 3'b001;
 linha_in_r = 4'b0010;
 sensor1_in_r = 1'b1;
 sensor2_in_r = 1'b1;
end

if(contador == 6100)begin
 coluna_in_r = 3'b000;
 linha_in_r = 4'b0000;
 sensor1_in_r = 1'b0;
 sensor2_in_r = 1'b0;
end

if(contador == 9100)begin
 sensor1_in_r = 1'b1;
 sensor2_in_r = 1'b1;
end

end
end




endmodule
