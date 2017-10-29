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
module CUmodule(aluopcode, aluin1, aluin2, aluout, toram, fromram, addressbus, read, write, clk, enable);
	
	`include "parameters.v"
	
	output reg [aluwidth-1:0] aluin1=0;
	output reg [aluwidth-1:0] aluin2=0;
	output reg [opsize-1:0] aluopcode=0;
	input [aluwidth-1:0] aluout;
	output reg [adlines-1:0] addressbus=0;
	input enable;
	output reg read=0,write=0;
	
	input [datalines-1:0] fromram;
	output [datalines-1:0] toram;
	
	
	input clk;
	reg [datalines-1:0] pc=0, instreg=0, ramwrite_reg=0;
	reg [datalines-1:0] r [numRegs-1:0];
	
	assign toram = ramwrite_reg;

	integer i;

	initial
	begin
		for(i=0;i<numRegs;i=i+1) begin
			r[i]=0;
		end
	end
	
	reg [statesize-1:0] STATE = `FETCH;
	


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
				STATE = `DECODE;
			end
			`DECODE:
			begin
				instreg = fromram;
				read = 0;
				write = 0;
				case(instreg[opsize-1:0])
					`LDI:
					begin
						r[instreg[opsize+intRegAddr-1:opsize]] = instreg[datalines-1:opsize+intRegAddr];
					end
					`STI: 
					begin
						addressbus = r[instreg[opsize+intRegAddr-1:opsize]][adlines-1:0];
						ramwrite_reg = instreg[datalines-1:opsize+intRegAddr];
						read = 0;
						write = 1;
					end
					`LD:
					begin
						addressbus = r[instreg[opsize+intRegAddr+intRegAddr-1:opsize+intRegAddr]][adlines-1:0];
						read = 1;
						write = 0;
					end
					`ST: 
					begin
						addressbus = r[instreg[opsize+intRegAddr-1:opsize]][adlines-1:0];
						ramwrite_reg = r[instreg[opsize+intRegAddr+intRegAddr-1:opsize+intRegAddr]];
						read = 0;
						write = 1;
					end
					`MOV:
					begin
						r[instreg[opsize+intRegAddr-1:opsize]] = r[instreg[opsize+intRegAddr+intRegAddr-1:opsize+intRegAddr]];	
					end
					default:
					begin
						aluopcode = instreg[opsize-1:0];
						aluin1 = r[instreg[opsize+intRegAddr+intRegAddr-1:opsize+intRegAddr]];
						aluin2 = r[instreg[opsize+intRegAddr+intRegAddr+intRegAddr-1:opsize+intRegAddr+intRegAddr]];
					end
				endcase
			STATE = `EXECUTE;
			end
			`EXECUTE:
			begin
					
				case(instreg[opsize-1:0])
					`LDI:
					begin
					end
					`LD:
					begin
						r[instreg[opsize+intRegAddr-1:opsize]] = fromram;
					end
					
					`STI: begin

					end
					`ST: begin

					end
					`MOV: begin

					end

					default:
					begin
						/*aluin1 = r[0];
						aluin2 = r[1];
						r[2] = aluout;
						aluopcode = instreg[opsize-1:0];*/
						r[instreg[opsize+intRegAddr-1:opsize]] = aluout;
					end
				endcase
				STATE = `FETCH;

			end
		endcase
		end
	end

endmodule
