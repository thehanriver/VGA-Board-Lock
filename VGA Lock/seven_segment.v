`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:11:06 04/07/2016 
// Design Name: 
// Module Name:    seven_segment 
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
module seven_segment(
    input clk,
	 input [19:0] big_bin,
	 
	 output reg [3:0] AN,
	 output [6:0] seven_out
    );
reg [1:0] count; 
reg [4:0] seven_in;
//parameter GETFIRSTDIGIT = 6'b000001; // get_first_input_state // this is not a must, one can use counter instead of having another step, design choice
//parameter GETSECONDIGIT = 6'b000010; //get_second input state
//parameter GETTHIRDIGIT = 6'b000100;
//parameter GETFOURTHDIGIT = 6'b001000;

	initial begin // Initial block , used for correct simulations
		AN = 4'b1110;
		seven_in = 0;
		count = 0;
	end
	
		//tranlate to 7 LED values
//Always block is missing...
binary_to_segment disp0(seven_in,seven_out);

// Also count value is operating in very  high frequency? Think about how to fix it!
always @(posedge clk) begin
count <= count + 1;
	case (count)
	 0: begin 
		AN <= 4'b1110;
		seven_in<=big_bin[19:15];
	 end
	 
	1: begin
	AN <= 4'b1101;
	//if(current_state == GETSECONDIGIT)
		//seven_in<=5'b11111;
	//else
		seven_in <= big_bin[14:10];
	end
	2: begin
		AN <= 4'b1011;
		//if(current_state == GETTHIRDIGIT)
			//seven_in<=5'b11111;
		//else
		seven_in <= big_bin[9:5];
		
	end
	3: begin
	AN <= 4'b0111;
	//if(current_state == GETFOURTHDIGIT)
				//seven_in<=5'b11111;
	 //else
		      seven_in <= big_bin[4:0];
	end
	
	
	endcase
	
end

endmodule