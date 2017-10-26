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

	// Inputs
	reg [9:0] address;
	reg read;
	reg write;
	reg clk;

	// Bidirs
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	RAMblock uut (
		.address(address), 
		.data(data), 
		.read(read), 
		.write(write),
		.clk(clk)
	);

	assign data = write ? temp : 8'bz;

	reg [7:0] temp;
	
	always begin
		clk = ~clk;
		#10;
	end

	initial begin
		// Initialize Inputs
		address = 0;
		read = 0;
		write = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		
		address = 1;
		temp = 5;
		#10
		write = 1;
		
		#100
		write = 0;
		temp = 0;
		#100
		address = 2;
		temp = 10;
		#10
		write = 1;
		#100
		write =0;
		#100
		address = 1;
		#100
		read = 1;
		#100
		read = 0;
		
		

	end
      
endmodule

