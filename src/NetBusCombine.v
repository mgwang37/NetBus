`timescale 1ns / 1ps

module NetBusCombine#(
	parameter  DATA_WIDTH = 4
)(
    input   [DATA_WIDTH*8-1:0]   DATAX,
    input     [DATA_WIDTH-1:0]   STRB,
    input                [1:0]   CMD,
	input                [4:0]   DID,
    input                [4:0]   SID,
    input                        FIRST,
    input                        LAST,

	output [DATA_WIDTH*9+13:0]   DATA
);

assign DATA = {DATAX,STRB,CMD,DID,SID,FIRST,LAST};

endmodule
