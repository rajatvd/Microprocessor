`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
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
	wire [15:0] aluout;
	reg clk;
	reg enable;

	// Outputs
	wire [2:0] aluopcode;
	wire [15:0] aluin1;
	wire [15:0] aluin2, r0,r1,r2,instruction;
	wire [4:0] addressbus;
	wire read;
	wire write;

	// Bidirs
	wire [15:0] databus;

	// Instantiate the Unit Under Test (UUT)
	CUmodule uut (
		.aluopcode(aluopcode), 
		.aluin1(aluin1), 
		.aluin2(aluin2), 
		.aluout(aluout), 
		.databus(databus), 
		.addressbus(addressbus), 
		.read(read), 
		.write(write), 
		.clk(clk),
		.enable(enable),
		.r0(r0),
		.r1(r1),
		.r2(r2),
		.insreg(instruction)
	);
	
	reg [15:0] data;
	reg [4:0] addr;
	reg red,writ;
	wire [15:0] data2;
	wire [4:0] addr2;
	wire red2,writ2;
	assign addr2 = enable?addressbus:addr;
	assign data2 = enable?databus:data;
	assign red2 = enable?read:red;
	assign writ2 = enable?write:writ;
	
	RAMblock ram(
		.address(addr2), 
		.data(data2), 
		.read(red2), 
		.write(writ2),
		.clk(clk)
	);
	
	ALUmodule alu(
		.opcode(aluopcode), 
		.in1(aluin1), 
		.in2(aluin2), 
		.out(aluout)
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
      
		addr = 16;
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
		
		enable = 1;
		
		#1000
		$finish;

	end
      
endmodule

