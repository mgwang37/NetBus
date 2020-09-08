/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 08/12/2020 09:00:52 AM
** Design Name:
** Module Name: NetBusAsynFIFO
** Project Name: NetBus
** Description:
**
** Dependencies:
**
** Revision:
** Revision 0.01 - File Created
** Additional Comments:
*/

`timescale 1ns / 1ps

module NetBusAsynFIFO#(
    parameter  DATA_WIDTH  = 4,
    parameter  FIFO_DEPTH  = 4,
    parameter  SYNC_STAGES = 2
)(
    input                        RESETn,

    input                        WCLK,
    input    [DATA_WIDTH*9+13:0] WDATA,
    input                        WVALID,
    output                       WREADY,

    input                        RCLK,
    output   [DATA_WIDTH*9+13:0] RDATA,
    output                       RVALID,
    input                        RREADY,
	output                       RFRAME
);

reg  [FIFO_DEPTH:0] w_frame;
wire [FIFO_DEPTH:0] w_frame_g;

reg  [FIFO_DEPTH:0] r_frame;
wire [FIFO_DEPTH:0] r_frame_g;
wire [FIFO_DEPTH:0] r_w_frame_g;
assign w_frame_g = (w_frame >> 1) ^ w_frame;
assign r_frame_g = (r_frame >> 1) ^ r_frame;
assign RFRAME = (r_w_frame_g == r_frame_g) ? 1'b0 : 1'b1;

AsyncInputSync #(
	.SYNC_STAGES(SYNC_STAGES),
	.DATA_WIDTH(FIFO_DEPTH+1)
) sync_frame (
	.CLK(RCLK),
	.ASYNC_IN(w_frame_g),
	.SYNC_OUT(r_w_frame_g)
);

always @(posedge WCLK or negedge RESETn)begin
	if (!RESETn)begin
		w_frame <= 0;
	end else if (WREADY & WVALID & WDATA[0]) begin
		w_frame <= w_frame +1;
	end
end

always @(posedge RCLK or negedge RESETn)begin
	if (!RESETn)begin
		r_frame <= 0;
	end else if (RREADY & RVALID & RDATA[0]) begin
		r_frame <= r_frame +1;
	end
end

reg  [FIFO_DEPTH:0] w_addr;
wire [FIFO_DEPTH:0] w_addr_g;
wire [FIFO_DEPTH:0] w_r_addr_g;

reg  [FIFO_DEPTH:0] r_addr;
wire [FIFO_DEPTH:0] r_addr_g;
wire [FIFO_DEPTH:0] r_w_addr_g;

assign r_addr_g = (r_addr >> 1) ^ r_addr;
assign RVALID = (r_addr_g[FIFO_DEPTH:0] == r_w_addr_g[FIFO_DEPTH:0]) ? 1'b0 : 1'b1;

assign w_addr_g = (w_addr >> 1) ^ w_addr;
assign WREADY = ((w_addr_g[FIFO_DEPTH:0] ^ w_r_addr_g[FIFO_DEPTH:0]) == (2'b11 << (FIFO_DEPTH-1))) ? 1'b0 : 1'b1;

AsyncInputSync #(
	.SYNC_STAGES(SYNC_STAGES),
	.DATA_WIDTH(FIFO_DEPTH+1)
) sync_w (
	.CLK(WCLK),
	.ASYNC_IN(r_addr_g),
	.SYNC_OUT(w_r_addr_g)
);

always @(posedge WCLK or negedge RESETn)begin
	if (!RESETn)begin
		w_addr <= 0;
	end else if (WREADY & WVALID) begin
		w_addr <= w_addr +1;
	end
end

AsyncInputSync #(
	.SYNC_STAGES(SYNC_STAGES),
	.DATA_WIDTH(FIFO_DEPTH+1)
) sync_r (
	.CLK(RCLK),
	.ASYNC_IN(w_addr_g),
	.SYNC_OUT(r_w_addr_g)
);

always @(posedge RCLK or negedge RESETn)begin
	if (!RESETn)begin
		r_addr <= 0;
	end else if (RREADY & RVALID) begin
		r_addr <= r_addr +1;
	end
end

NetBusAsynFIFOMem #(
	.RAM_WIDTH(DATA_WIDTH*9+14),
	.RAM_DEPTH(FIFO_DEPTH)
) mem (
	.WADDR(w_addr[FIFO_DEPTH-1:0]),
	.RADDR(r_addr[FIFO_DEPTH-1:0]),
	.DIN(WDATA),
	.CLKW(WCLK),
	.CLKR(RCLK),
	.WEN(WVALID&WREADY),
	.DOUT(RDATA)
);

endmodule
