`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:07:52 04/19/2019 
// Design Name: 
// Module Name:    Bin_to_Hex 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Bin_to_Hex(input [3:0] bin, output reg hex_digit);

	assign hex_digit = (bin == 4'b0000) ? 1'h0:
	(bin == 4'b0001) ? 1'h1:
	(bin == 4'b0010) ? 1'h2:
	(bin == 4'b0011) ? 1'h3:
	(bin == 4'b0100) ? 1'h4:
	(bin == 4'b0101) ? 1'h5:
	(bin == 4'b0110) ? 1'h6:
	(bin == 4'b0111) ? 1'h7:
	(bin == 4'b1000) ? 1'h8:
	(bin == 4'b1001) ? 1'h9:
	(bin == 4'b1010) ? 1'hA:
	(bin == 4'b1011) ? 1'hB:
	(bin == 4'b1100) ? 1'hC:
	(bin == 4'b1101) ? 1'hD:
	(bin == 4'b1110) ? 1'hE: 1'hF;
	
	

endmodule
