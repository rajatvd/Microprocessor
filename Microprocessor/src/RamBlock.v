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
module RAMblock(address,data,read,write,clk);
	
	`include "parameters.v"

	input [adlines-1:0] address;
	inout [datalines-1:0] data;
	input read;
	input write;
	input clk;
	
	reg [datalines-1:0] memory [ramsize-1:0];
	reg [datalines-1:0] temp;
	
	assign data = read ? temp : 32'bz;
	
	always @ (posedge clk)
	begin
		if(write) begin
			memory[address] = data;
		end	
		temp = memory[address];
	end
endmodule
