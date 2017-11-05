`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Author: Rajat Vadiraj Dwaraknath EE16B033 
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
module CUmodule(aluopcode, aluin1, aluin2, aluout, toram, fromram, addressbus, flags, read, write, clk, enable);
	
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
	
	input [numflags-1:0] flags;
	reg [numflags-1:0] fls=0;
	
	input clk;
	reg [adlines-1:0] pc=0;
	reg [datalines-1:0] instreg=0, ramwrite_reg=0;
	reg [datalines-1:0] r [numRegs-1:0];
	
	assign toram = ramwrite_reg;

	integer i;

	// Initialize internal registers.
	initial
	begin
		for(i=0;i<numRegs;i=i+1) begin
			r[i]=0;
		end
	end
	
	reg [statesize-1:0] STATE = `FETCH;
	


	// Wires to allow registers to be dumped into dumpfile
	wire [datalines-1:0]	r0 = r[0],
	r1 = r[1],
	r2 = r[2],
	r3 = r[3],
	r4 = r[4],
	r5 = r[5],
	r6 = r[6],
	r7 = r[7],
	r8 = r[8],
	r9 = r[9],
	r10 = r[10],
	r11 = r[11],
	r12 = r[12],
	r13 = r[13],
	r14 = r[14],
	r15 = r[15];


	always @(posedge clk)
	begin
		// Main CPU cycle
		if(enable == 1)
		begin
		case(STATE)
			`FETCH:
			begin
				// Get isntruction from memory
				pc = pc+1;
				addressbus = pc;
				read = 1;
				write = 0;
				STATE = `DECODE;
			end
			`DECODE:
			begin
				// Load instruction into instruction register
				instreg = fromram;
				read = 0;
				write = 0;

				// Decode based on opcode
				case(instreg[opsize-1:0])
					`LDI:
					begin
						// LDI Rx, #y
						// Loads the literal value y into register Rx.
						r[instreg[opsize+intRegAddr-1:opsize]] = instreg[datalines-1:opsize+intRegAddr];
					end
					`STI: 
					begin
						// STI Rx, #y
						// Stores the literal value y, into the RAM at address given by the value of register Rx.
						addressbus = r[instreg[opsize+intRegAddr-1:opsize]][adlines-1:0];
						ramwrite_reg = instreg[datalines-1:opsize+intRegAddr];
						read = 0;
						write = 1;
					end
					`LD:
					begin
						// LD Rx, Ry
						// Loads the value in RAM at address Ry, into the register Rx.

						// Asserts ram signals in this state and loads in next state.
						addressbus = r[instreg[opsize+intRegAddr+intRegAddr-1:opsize+intRegAddr]][adlines-1:0];
						read = 1;
						write = 0;
					end
					`ST: 
					begin
						// ST Rx, Ry
						// Stores the value of register Rx into RAM at address Ry.

						addressbus = r[instreg[opsize+intRegAddr+intRegAddr-1:opsize+intRegAddr]][adlines-1:0];
						ramwrite_reg = r[instreg[opsize+intRegAddr-1:opsize]];
						read = 0;
						write = 1;
					end
					`MOV:
					begin
						// MOV Rx, Ry
						// Rx = Ry

						r[instreg[opsize+intRegAddr-1:opsize]] = r[instreg[opsize+intRegAddr+intRegAddr-1:opsize+intRegAddr]];	
					end

					`CMP: begin
						// CMP Rx, Ry
						// Sets flags after doing Rx-Ry

						aluopcode = instreg[opsize-1:0];
						aluin1 = r[instreg[opsize+intRegAddr-1:opsize]];
						aluin2 = r[instreg[opsize+intRegAddr+intRegAddr-1:opsize+intRegAddr]];
					end

					`BI: begin
						// BI $label
						// Branch immediate. Sets the program counter to the literal value given in the instruction, minus 1.
						// Literal values usually given as label references.

						pc = instreg[opsize+adlines-1:opsize]-1;
					end
					`BCI: begin
						// BCI $label
						// Branch if carry set.

						if(fls[3]==1)
							pc = instreg[opsize+adlines-1:opsize]-1;
					end
					`BNEI: begin
						// BNEI $label
						// Branch if not equal. (Zero flag is not set)

						if(fls[1]!=1)
							pc = instreg[opsize+adlines-1:opsize]-1;
					end
					`HALT: begin
						// HALT
						// Halts the processor
						STATE = `IDLE;
					end

					default:
					begin
						// All other opcodes are ALU operations. They are of the format:
						// OP Rd, Rx, Ry
						// Rd = OP(Rx,Ry)

						// Asserts alu signals in this state and stores output in next state.
						aluopcode = instreg[opsize-1:0];
						aluin1 = r[instreg[opsize+intRegAddr+intRegAddr-1:opsize+intRegAddr]];
						aluin2 = r[instreg[opsize+intRegAddr+intRegAddr+intRegAddr-1:opsize+intRegAddr+intRegAddr]];
					end
				endcase
			if(STATE != `IDLE)
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
						// Load value read from ram into register
						r[instreg[opsize+intRegAddr-1:opsize]] = fromram;
					end
					
					`STI: begin

					end
					`ST: begin

					end
					`MOV: begin

					end
					`CMP: begin
						// Update flags after comparing
						fls = flags;
					end

					`BI: begin

					end
					`BCI: begin

					end
					`BNEI: begin

					end


					default:
					begin
						// Load output of ALU operation into destination register, and update flags.
						r[instreg[opsize+intRegAddr-1:opsize]] = aluout;
						fls = flags;
					end
				endcase
				STATE = `FETCH;

			end
		endcase
		end
	end

endmodule
