module vendingmachine(botao_in, s1_in, s2_in, r_out);
	input wire botao_in, s1_in, s2_in;
	output wire r_out;
	
	// y = s1_in'*s2_in' + B*s1_in' + B*s2_in'
	
	assign r_out = (s1_in! * s2_in!) + (botao_in * s1_in!) + (botao_in * s2_in!);

	
endmodule
