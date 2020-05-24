`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:48:52 04/22/2019 
// Design Name: 
// Module Name:    clock_dividerVGA 
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
module clock_dividerVGA (
  input clock_in,
  input reset,
  output reg clock_out
);

reg [1:0] count;

always@(posedge clock_in or posedge reset) begin
  if(reset) begin
    count <= 2'b00;
  end else begin
    count <= count + 1'b1;
  end
end

always@(posedge clock_in or posedge reset) begin
  if(reset) begin
    clock_out <= 1'b0;
  end else begin
    clock_out <= count[1];
  end
end

endmodule

