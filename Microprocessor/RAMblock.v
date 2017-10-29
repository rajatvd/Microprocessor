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
	`include "../code.v"

	input [adlines-1:0] address;
	input [datalines-1:0] datain;
	output [datalines-1:0] dataout;
	input read;
	input write;
	
	reg [datalines-1:0] memory [ramsize-1:0];
	reg [datalines-1:0] temp;

	integer i;

	initial begin
		temp = 0;
		
		/*memory[1] = 16'b100000110;
		memory[2] = 16'b11000100010110;
		memory[3] = 16'b001100011000;
		memory[4] = 0;
		memory[5] = 16'b10101010100111;
		memory[16] = 15;
		memory[17] = 4;*/

		/*for(i=0;i<7;i=i+1) begin
			memory[ADDRESSES[i]] = DATA[i];
		end*/
		`writeRam

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
