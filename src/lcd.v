module lcd(reset_in, clock_in, numgiro_in, lcd_out, enlcd_out, rslcd_out, rwlcd_out);

// input
input reset_in, clock_in;
input wire [3:0] numgiro_in;

// output
output wire [7:0] lcd_out;
output wire enlcd_out, rslcd_out, rwlcd_out;

// reg


// logica do lcd
assign lcd_out = {4'b0000, numgiro_in};
assign enlcd_out = 1'b0;
assign rslcd_out = 1'b0;
assign rwlcd_out = 1'b0;

endmodule
