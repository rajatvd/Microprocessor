`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Author: Rajat Vadiraj Dwaraknath EE16B033 
//
// Create Date:   14:55:22 10/17/2017
// Design Name:   CUmodule
// Module Name:   C:/Users/students/Desktop/8bitProcessorRollNum33_35/microprocessor/CUTester.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CUmodule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CUTester;

	`include "parameters.v"

	// Inputs
	reg clk;
	reg enable;

	// Outputs
	wire [opsize-1:0] aluopcode;
	wire [aluwidth-1:0] aluin1, aluin2, aluout;
	wire [numflags-1:0] flags;
	wire [adlines-1:0] addressbus;
	wire read;
	wire write;

	// Bidirs
	wire [datalines-1:0] fromram, toram;

	// Instantiate the Unit Under Test (UUT)
	CUmodule cu (
		.aluopcode(aluopcode), 
		.aluin1(aluin1), 
		.aluin2(aluin2), 
		.aluout(aluout), 
		.fromram(fromram), 
		.toram(toram), 
		.addressbus(addressbus), 
		.read(read), 
		.write(write),
		.flags(flags),
		.clk(clk),
		.enable(enable)
	);
	
	RAMblock ram(
		.address(addressbus), 
		.datain(toram),
		.dataout(fromram),
		.read(read), 
		.write(write)
	);
	
	ALUmodule alu(
		.opcode(aluopcode), 
		.in1(aluin1), 
		.in2(aluin2), 
		.out(aluout),
		.flags(flags)
	);

	always begin
		clk = ~clk;
		#10;
	end

	initial begin
		$dumpfile("cu.vcd");
		$dumpvars;
		// Initialize Inputs
		clk = 0;
		enable = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
	/*	addr = 16;
		data = 5;
		writ = 1;
		red = 0;
		#100
		writ=0;
		red=0;
		
		addr = 17;
		data = 2;
		writ = 1;
		red = 0;
		#100
		writ=0;
		red=0;
		
		addr = 1;
		data = 16'b010000110;
		writ = 1;
		red = 0;
		#100
		writ=0;
		red=0;
		
		addr = 2;
		data = 16'b110001110;
		writ = 1;
		red = 0;
		#100
		writ=0;
		red=0;
		
		addr = 3;
		data = 16'b0;
		writ = 1;
		red = 0;
		#100
		writ=0;
		red=0;
	*/	
		enable = 1;
		
		#5000000
		$finish;

	end
      
endmodule

