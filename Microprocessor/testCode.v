
/*
   parameter integer ADDRESSES [7:0] = {1,2,3,4,5,16,17};
   parameter integer  DATA [7:0] = {16'b100000110,
   16'b11000100010110,
   16'b001100011000,
   0,
   16'b10101010100111,
   15,
   4};
 */

/*
`define writeRam(mem) \
		(mem)[1] = 16'b100000110; \
		(mem)[2] = 16'b11000100010110; \
		(mem)[3] = 16'b001100011000; \
		(mem)[4] = 0; \
		(mem)[5] = 16'b10101010100111; \
		(mem)[16] = 15; \
		(mem)[17] = 4; 
*/
`define writeRam \
		memory[1] = 16'b00010100010110; \
		memory[2] = 16'b01000110000110; \
		memory[3] = 16'b00100000111000; \
		memory[4] = 16'b00001100010000; \
		memory[16] = 15; \
		memory[17] = 4; 

