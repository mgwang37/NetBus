`timescale 1ns / 1ps

module NetBusSplit#(
	parameter  DATA_WIDTH = 4 
)(
	input   [DATA_WIDTH*9+11:0]   DATA,

    output   [DATA_WIDTH*8-1:0]   DATAX,
    output     [DATA_WIDTH-1:0]   STRB,
    output                [1:0]   CMD,
	output                [4:0]   DID,
    output                [4:0]   SID,
    output                        FIRST,
    output                        LAST
);
	assign  DATAX  = DATA[DATA_WIDTH*9+13:DATA_WIDTH+14];
	assign  STRB   = DATA[DATA_WIDTH+13:14];
	assign  CMD    = DATA[13:12];
	assign  DID    = DATA[11:7];
	assign  SID    = DATA[6:2];
	assign  FIRST  = DATA[1];
	assign  LAST   = DATA[0];

endmodule
