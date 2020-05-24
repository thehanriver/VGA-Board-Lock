`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:37:25 04/21/2019 
// Design Name: 
// Module Name:    Master 
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
module Master(input clk,
    input rst,
    input clr,
    input ent,
    input change,
	output [5:0] led,
	output [19:0] ssd,
    input [3:0] sw,
	 input [3:0] bd,
	 output[3:0] anodes,
	 output [6:0] cathodes,
	 output [2:0] R, G,
    output[1:0]  B,
    output HS, VS, light);
	 
wire superc,nclock, cccc;
clk_divider newClock(clk,rst,nclock);
clk_divider25 master_clock(clk,rst,superc);
clk_divider12 caseclock(clk, rst, cccc);

debouncer newclear(superc,rst,clr,nclr);
debouncer newenter(superc,rst,ent,nent);
debouncer newchange(superc,rst,change,nchange);

Project_Start ASM(superc,nclock, cccc,rst,nclr,nent,nchange,led,ssd,sw,bd,anodes,cathodes); 
vga_display v1(rst, cccc,ssd, R,G,B,HS,VS,light);

endmodule
