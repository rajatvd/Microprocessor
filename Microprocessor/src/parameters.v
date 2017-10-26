//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:02:29 10/17/2017 
// Design Name: 
// Module Name:    parameters 
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
`define ADD 0
`define SUB 1
`define AND 2
`define OR 3
`define LS 4
`define RS 5
`define LOAD 6
`define STORE 7

`define FETCH 0
`define DECODE 1
`define EXECUTE 2


parameter adlines = 5;
parameter datalines = 16;
parameter ramsize = 1 << adlines;
parameter aluwidth = 16;
parameter opsize = 3;
parameter statesize = 4;
