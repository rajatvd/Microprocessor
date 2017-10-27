`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:38:07 10/10/2017
// Design Name:   RAMblock
// Module Name:   C:/Users/students/Desktop/8bitProcessor/microprocessor/Tester.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RAMblock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Tester;

	`include "parameters.v"
	// Inputs
	reg [adlines-1:0] address;
	reg read;
	reg write;
	reg [datalines-1:0] datain;

	// Outputs
	wire [datalines-1:0] dataout;

	// Instantiate the Unit Under Test (UUT)
	RAMblock uut (
		.address(address), 
		.datain(datain), 
		.dataout(dataout), 
		.read(read), 
		.write(write)
	);

	initial begin
		$dumpfile("ram.vcd");
		$dumpvars;
		// Initialize Inputs
		address = 0;
		read = 0;
		write = 0;
		datain = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		datain = 10;
		address = 11;
		write = 1;
		#100;
		write = 0;
		#10
		address = 0;
		datain = 0;
		#10
		datain = 17;
		address = 19;
		write = 1;
		#100;
		write = 0;
		address = 0;
		datain = 0;
		#10
		datain = 1003;
		address = 65;
		write = 1;
		#100;
		write = 0;
		address = 0;
		datain = 0;
		#10
		
		read = 1;
		#10

		address = 0;
		#100
		
		address = 1;
		#100
		
		address = 2;
		#100
		
		address = 11;
		#100
		
		address = 17;
		#100

		address = 65;
		#100

		address = 19;
		#100
		
		

		$finish;
		

	end
      
endmodule

