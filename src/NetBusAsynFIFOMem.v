module NetBusAsynFIFOMem #(
	parameter RAM_WIDTH = 16,                    
	parameter RAM_DEPTH = 4
)(
	input [RAM_DEPTH-1:0]   WADDR,
	input [RAM_DEPTH-1:0]   RADDR,
	input [RAM_WIDTH-1:0]   DIN,
	input                   CLKW,
	input                   CLKR,
	input                   WEN,
	output [RAM_WIDTH-1:0]  DOUT  
);

reg [RAM_WIDTH-1:0] BRAM [(1<<RAM_DEPTH)-1:0];
reg [RAM_WIDTH-1:0] out_reg;

always @(posedge CLKW)begin
    if (WEN)begin
		BRAM[WADDR] <= DIN;
	end
end

always @(posedge CLKR)begin
	out_reg <= BRAM[RADDR];
end

assign DOUT = out_reg;

endmodule
