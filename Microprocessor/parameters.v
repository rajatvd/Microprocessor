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
`define LDI 6
`define STI 7
`define MOV 8
`define LD 9
`define ST 10


`define FETCH 0
`define DECODE 1
`define EXECUTE 2


parameter adlines = 8;
parameter datalines = 16;
parameter ramsize = 1 << adlines;
parameter aluwidth = 16;
parameter opsize = 4;
parameter statesize = 4;
parameter intRegAddr = 4;
parameter numRegs = 1 << intRegAddr;

