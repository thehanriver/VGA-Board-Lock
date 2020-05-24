`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:48:59 04/20/2019 
// Design Name: 
// Module Name:    binary_to_segment 
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
module binary_to_segment(input [4:0] seven_in, output reg [6:0] seven_out);


always @(*)
begin
	case(seven_in)
		5'b00000: seven_out = 7'b0000001; //0
		5'b00001: seven_out = 7'b1001111; //1
		5'b00010: seven_out = 7'b0010010; //2
		5'b00011: seven_out = 7'b0000110; //3
		5'b00100: seven_out = 7'b1001100; //4
		5'b00101: seven_out = 7'b0100100; //5
		5'b00110: seven_out = 7'b0100000; //6
		5'b00111: seven_out = 7'b0001111; //7
		5'b01000: seven_out = 7'b0000000; //8
		5'b01001: seven_out = 7'b0000100; //9
		5'b01010: seven_out = 7'b0001000; //A
		5'b01011: seven_out = 7'b1100000; //B
		5'b01100: seven_out = 7'b0110001; //C
		5'b01101: seven_out = 7'b1000010; //D
		5'b01110: seven_out = 7'b0110000; //E
		5'b01111: seven_out = 7'b0111000; //F
	
	
	
		5'b10000: seven_out = 7'b0110001; //C in "CLSd"
		5'b10001: seven_out = 7'b1110001; //L in "CLSd"
		5'b10010: seven_out = 7'b0100100; //S in "CLSd"
		5'b10011: seven_out = 7'b1000010; //d in "CLSd"
		5'b10111: seven_out = 7'b0011000; //P in "OPEn"
		5'b11000: seven_out = 7'b1101010; //n in "OPEn"
		5'b11001: seven_out = 7'b1111111; //blank
		5'b11010: seven_out = 7'b1000001; //V
		5'b11011: seven_out = 7'b1001111; //I
		5'b11111: seven_out = 7'b1111110; //tire
		default: seven_out = 7'b1111110; //0 or "O"
	endcase
end
endmodule
