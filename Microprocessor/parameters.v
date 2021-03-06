//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Author: Rajat Vadiraj Dwaraknath EE16B033 
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

// OPCODES
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
`define CMP 11
`define BCI 12
`define BNEI 13
`define BI 14
`define HALT 15



// CU STATES
`define FETCH 0
`define DECODE 1
`define EXECUTE 2
`define IDLE 3


// BUS SIZES
parameter adlines = 8;
parameter datalines = 16;
parameter ramsize = 1 << adlines;
parameter aluwidth = 16;
parameter opsize = 4;
parameter statesize = 4;
parameter intRegAddr = 4;
parameter numRegs = 1 << intRegAddr;

// FLAGS : C V N Z
parameter numflags = 4;
