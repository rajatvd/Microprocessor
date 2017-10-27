`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:36 10/10/2017 
// Design Name: 
// Module Name:    ALUmodule 
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

module ALUmodule(opcode, in1, in2, out);
	
	`include "parameters.v"

	input [opsize-1:0] opcode;
	input [aluwidth-1:0] in1;
	input [aluwidth-1:0] in2;
	output [aluwidth-1:0] out;
	//output reg flag;
	
	assign out = 
	(opcode == `ADD)*(in1 + in2) |
	(opcode == `SUB)*(in1 - in2) |
	(opcode == `AND)*(in1 & in2) |
	(opcode == `OR)*(in1 | in2) |
	(opcode == `LS)*(in1<<in2) |
	(opcode == `RS)*(in1>>in2);
	
	/*always @* begin
		if(opcode==`ADD) begin
			out = in1+in2;
		end
	 
		if(opcode==`SUB) begin
			out = in1-in2;
		end
		
		if(opcode==`AND) begin
			out = in1 & in2;
		end
		
		if(opcode==`OR) begin
			out = in1 | in2;
		end
		
		if(opcode==`LS) begin
			out = in1<<in2;
		end
		
		if(opcode==`RS) begin
			out = in1>>in2;
		end
	end
	
	
*/
endmodule
