`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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

	input [adlines-1:0] address;
	input [datalines-1:0] datain;
	output [datalines-1:0] dataout;
	input read;
	input write;
	
	reg [datalines-1:0] memory [ramsize-1:0];
	reg [datalines-1:0] temp;

	initial begin
		temp = 0;
	end
	
	assign dataout = read ? temp : 0;
	
	always @*
	begin
		if(write == 1)
		begin
			memory[address] = datain;
		end
		
		if(read == 1)
		begin
			temp = memory[address];
		end
	end

endmodule
