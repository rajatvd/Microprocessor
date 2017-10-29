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

module ALUmodule(opcode, in1, in2, out, flags);
	
	`include "parameters.v"

	input [opsize-1:0] opcode;
	input [aluwidth-1:0] in1;
	input [aluwidth-1:0] in2;
	output [aluwidth-1:0] out;
	
	// flags = {C V Z N}
	output [numflags-1:0] flags;

	
	assign out = 
	(opcode == `ADD)*(in1 + in2) |
	(opcode == `SUB)*(in1 - in2) |
	(opcode == `AND)*(in1 & in2) |
	(opcode == `OR)*(in1 | in2) |
	(opcode == `LS)*(in1 << in2) |
	(opcode == `RS)*(in1 >> in2);

	
	reg [numflags-1:0] fl = 0;
	reg [aluwidth-1:0] temp = 0;

	assign flags = fl;

	always @* begin

		fl[0] = out[aluwidth-1];
		fl[1] = (out == 0);
		if(in1[aluwidth-1]==in2[aluwidth-1]) 
			fl[2] = (in1[aluwidth-1]!=out[aluwidth-1]);
		else
			fl[2] = 0;
		
		if(opcode==`ADD) 
			{fl[3],temp} = in1+in2;
		else if(opcode == `SUB)
			{fl[3],temp} = in1-in2;
		else
			fl[3]=  0;

	end


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
