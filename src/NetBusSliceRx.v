/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 08/12/2020 09:00:52 AM
** Design Name:
** Module Name: NetBusSliceRx 
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

module NetBusSliceRx#(
    parameter  DATA_WIDTH = 4,
	parameter  PORT_ROUTE = 32'h00000000,
    parameter  FIFO_DEPTH = 4,
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

wire [31:0] dest_id_mask;
wire        id_ok;
wire        wready_org;

assign dest_id_mask = 32'h1 << WDATA[11:7];

assign id_ok = (PORT_ROUTE & dest_id_mask) == 32'h0 ? 1'b0 : 1'b1;

assign WREADY = id_ok & wready_org;

NetBusAsynFIFO#(
	.DATA_WIDTH(DATA_WIDTH),
	.FIFO_DEPTH(FIFO_DEPTH),
	.SYNC_STAGES(SYNC_STAGES)
) asyn_fifo (
	.RESETn(RESETn),

	.WCLK(WCLK),
	.WDATA(WDATA),
	.WVALID(WVALID & id_ok),
	.WREADY(wready_org),

	.RCLK(RCLK),
	.RDATA(RDATA),
	.RVALID(RVALID),
	.RREADY(RREADY),
	.RFRAME(RFRAME)
);

endmodule
