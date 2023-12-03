module display7seg
(
reset_in,
clock_in,
numgiro_in,
seg_out
);

// input
input reset_in, clock_in;
input [3:0] numgiro_in;

// output
output [6:0] seg_out;

// reg
reg [6:0] NumGiroConv;

always @(posedge clock_in or posedge reset_in)begin
	if(reset_in)begin
		NumGiroConv = 7'b0000000;
	end
	else begin
		// cátodo
		case (numgiro_in)
		 4'b0000: NumGiroConv = 7'b0111111; // '0'
		 4'b0001: NumGiroConv = 7'b0000110; // '1'
		 4'b0010: NumGiroConv = 7'b1011011; // '2'
		 4'b0011: NumGiroConv = 7'b1001111; // '3'
		 4'b0100: NumGiroConv = 7'b1100110; // '4'
		 4'b0101: NumGiroConv = 7'b1101101; // '5'
		 4'b0110: NumGiroConv = 7'b1111101; // '6'
		 4'b0111: NumGiroConv = 7'b0000111; // '7'
		 4'b1000: NumGiroConv = 7'b1111111; // '8'
		 4'b1001: NumGiroConv = 7'b1101111; // '9'
		 default: NumGiroConv = 7'b0000000; // Se não for um dígito, mostre '0'
		endcase
   end
end

assign seg_out = NumGiroConv;

endmodule
