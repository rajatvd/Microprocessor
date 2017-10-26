`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:57:54 10/17/2017 
// Design Name: 
// Module Name:    CUmodule 
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
module CUmodule(aluopcode, aluin1, aluin2, aluout, databus, addressbus, read, write, clk, enable,
r0,r1,r2,insreg);
	
	`include "parameters.v"
	
	output reg [aluwidth-1:0] aluin1=0;
	output reg [aluwidth-1:0] aluin2=0;
	output reg [opsize-1:0] aluopcode=0;
	input [aluwidth-1:0] aluout;
	output reg [adlines-1:0] addressbus=0;
	input enable;
	output reg read=0,write=0;
	
	output [datalines-1:0] r0,r1,r2,insreg;
	
	
	inout [datalines-1:0] databus;
	reg [datalines-1:0] temp=0;
	input clk;

	reg [datalines-1:0] pc=0,instreg=0;
	
	reg [datalines-1:0] r [5:0];
	
	initial
	begin
	r[0] = 0;
	r[1] = 0;
	r[2] = 0;
	end
	
	reg [statesize-1:0] STATE = `FETCH;
	
	assign databus = write ? temp : 32'bz;
	assign r0 = r[0];
	assign r1 = r[1];
	assign r2 = r[2];
	assign insreg = instreg;

	always @(posedge clk)
	begin
		if(enable == 1)
		begin
		case(STATE)
			`FETCH:
			begin
				pc = pc+1;
				addressbus = pc;
				read = 1;
				write = 0;
				instreg = databus;
				STATE <= `DECODE;
			end
			`DECODE:
			begin
				read = 0;
				write = 0;
				case(instreg[opsize-1:0])
					`LOAD:
					begin
						addressbus = instreg[opsize+adlines-1:opsize];
						read = 1;
						write = 0;
						r[instreg[opsize+adlines+2:opsize+adlines]] = databus;
					end
					`STORE: 
					begin
						addressbus = instreg[opsize+adlines-1:opsize];
						read = 0;
						write = 1;
						temp = r[instreg[opsize+adlines+2:opsize+adlines]];
					end
					default:
					begin
						aluin1 = r[0];
						aluin2 = r[1];
						r[2] = aluout;
						aluopcode = instreg[2:0];
					end
				endcase
				STATE = `FETCH;
			end
		endcase
		end
	end

endmodule
