`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:11:19 10/10/201aluwidth-1
// Design Name:   ALUmodule
// Module Name:   C:/Users/students/Desktop/8bitProcessor/microprocessor/ALUtester.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALUmodule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALUtester;
	`include "parameters.v"
	// Inputs
	reg [opsize-1:0] opcode;
	reg [aluwidth-1:0] in1;
	reg [aluwidth-1:0] in2;

	// Outputs
	wire [aluwidth-1:0] out;

	// Instantiate the Unit Under Test (UUT)
	ALUmodule uut (
		.opcode(opcode), 
		.in1(in1), 
		.in2(in2), 
		.out(out)
	);

	initial begin			
		$dumpfile("alu.vcd");
		$dumpvars;
		#1000
		// Initialize Inputs
		opcode = 0;
		in1 = 0;
		in2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		opcode = `ADD;
		in1 = 5;
		in2 = 2;
		
		#100
		
		opcode = `SUB;
		
		#100
		opcode = `AND;
		
		#100
		opcode = `OR;
		
		#100
		opcode = `LS;
		
		#100
		opcode = `RS;
		
		
		// Add stimulus here

		#1000
		$finish;
	end
      
endmodule

