`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Author: Rajat Vadiraj Dwaraknath EE16B033 
// 
// Create Date:    14:15:11 10/10/2017 
// Design Name: 
// Module Name:    RAMblock 
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
module RAMblock(address,datain,dataout,read,write);
	
	`include "parameters.v"
	`include "code.v"

	input [adlines-1:0] address;
	input [datalines-1:0] datain;
	output [datalines-1:0] dataout;
	input read;
	input write;
	
	reg [datalines-1:0] memory [ramsize-1:0];
	reg [datalines-1:0] temp;

	initial begin
		temp = 0;

		// Call the writeRam macro defined in "code.v".
		// The python assembler creates the "code.v" file with this macro in it, after
		// compiling assembly mnemonics into instruction code. Calling this simply 
		// initialises the memory.
		`writeRam

	end
	
	// Connect output wire to temp register only if read is asserted
	assign dataout = read ? temp : 0;
	
	always @*
	begin
		if(write == 1)
		begin
			// Write from datain to memory
			memory[address] = datain;
		end
		
		if(read == 1)
		begin
			// Load from memory into temp register, which in turn connects to dataout wire
			temp = memory[address];
		end
	end

endmodule
