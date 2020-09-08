/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 08/12/2020 09:00:52 AM
** Design Name:
** Module Name: NetBusMUX5 
** Project Name:  NetBus
** Description:
**
** Dependencies:
**
** Revision:
** Revision 0.01 - File Created
** Additional Comments:
*/

`timescale 1ns / 1ps

module NetBusMUX5#(
    parameter  DATA_WIDTH = 4,
	parameter  PORT_ROUTE = 32'h00000000,
    parameter  FIFO_DEPTH = 4,
    parameter  SYNC_STAGES = 2,
    parameter  REAL_TIME_PORT0 = 0,
    parameter  REAL_TIME_PORT1 = 0,
    parameter  REAL_TIME_PORT2 = 0,
    parameter  REAL_TIME_PORT3 = 0,
    parameter  REAL_TIME_PORT4 = 0
)(
	input                       RESETn,

	input                       WCLK,
    input   [DATA_WIDTH*9+13:0] WDATA,
    input                       WVALID,
    output                      WREADY,

    input                       RCLK,
    output  [DATA_WIDTH*9+13:0] RDATA,
    output                      RVALID,
    input                       RREADY,
	//+++++++++++++++++++++++++++++++++++++
    output                      WCLK0,
    output [DATA_WIDTH*9+13:0]  WDATA0,
    output                      WVALID0,
    input                       WREADY0,

    input                       RCLK0,
    input [DATA_WIDTH*9+13:0]   RDATA0,
    input                       RVALID0,
    output                      RREADY0,
	//+++++++++++++++++++++++++++++++++++++
    output                      WCLK1,
    output [DATA_WIDTH*9+13:0]  WDATA1,
    output                      WVALID1,
    input                       WREADY1,

    input                       RCLK1,
    input  [DATA_WIDTH*9+13:0]  RDATA1,
    input                       RVALID1,
    output                      RREADY1,
	//+++++++++++++++++++++++++++++++++++++
    output                      WCLK2,
    output [DATA_WIDTH*9+13:0]  WDATA2,
    output                      WVALID2,
    input                       WREADY2,

    input                       RCLK2,
    input  [DATA_WIDTH*9+13:0]  RDATA2,
    input                       RVALID2,
    output                      RREADY2,
	//+++++++++++++++++++++++++++++++++++++
    output                      WCLK3,
    output [DATA_WIDTH*9+13:0]  WDATA3,
    output                      WVALID3,
    input                       WREADY3,

    input                       RCLK3,
    input  [DATA_WIDTH*9+13:0]  RDATA3,
    input                       RVALID3,
    output                      RREADY3,
	//+++++++++++++++++++++++++++++++++++++
    output                      WCLK4,
    output [DATA_WIDTH*9+13:0]  WDATA4,
    output                      WVALID4,
    input                       WREADY4,

    input                       RCLK4,
    input  [DATA_WIDTH*9+13:0]  RDATA4,
    input                       RVALID4,
    output                      RREADY4
);

NetBusTx5#(
	.DATA_WIDTH(DATA_WIDTH) 
) tx (
	.CLK(WCLK),
	.DATA(WDATA),
	.VALID(WVALID),
	.READY(WREADY),

	.WCLK0(WCLK0),
	.WDATA0(WDATA0),
	.WVALID0(WVALID0),
	.WREADY0(WREADY0),

	.WCLK1(WCLK1),
	.WDATA1(WDATA1),
	.WVALID1(WVALID1),
	.WREADY1(WREADY1),

	.WCLK2(WCLK2),
	.WDATA2(WDATA2),
	.WVALID2(WVALID2),
	.WREADY2(WREADY2),

	.WCLK3(WCLK3),
	.WDATA3(WDATA3),
	.WVALID3(WVALID3),
	.WREADY3(WREADY3),

	.WCLK4(WCLK4),
	.WDATA4(WDATA4),
	.WVALID4(WVALID4),
	.WREADY4(WREADY4)
);

NetBusRx5#(
	.DATA_WIDTH(DATA_WIDTH), 
	.PORT_ROUTE(PORT_ROUTE),
	.FIFO_DEPTH(FIFO_DEPTH),
	.SYNC_STAGES(SYNC_STAGES),
	.REAL_TIME_PORT0(REAL_TIME_PORT0),
	.REAL_TIME_PORT1(REAL_TIME_PORT1),
	.REAL_TIME_PORT2(REAL_TIME_PORT2),
	.REAL_TIME_PORT3(REAL_TIME_PORT3),
	.REAL_TIME_PORT4(REAL_TIME_PORT4)
) rx (
	.RESETn(RESETn),

	.RCLK0(RCLK0),
	.RDATA0(RDATA0),
	.RVALID0(RVALID0),
	.RREADY0(RREADY0),

	.RCLK1(RCLK1),
	.RDATA1(RDATA1),
	.RVALID1(RVALID1),
	.RREADY1(RREADY1),

	.RCLK2(RCLK2),
	.RDATA2(RDATA2),
	.RVALID2(RVALID2),
	.RREADY2(RREADY2),

	.RCLK3(RCLK3),
	.RDATA3(RDATA3),
	.RVALID3(RVALID3),
	.RREADY3(RREADY3),

	.RCLK4(RCLK4),
	.RDATA4(RDATA4),
	.RVALID4(RVALID4),
	.RREADY4(RREADY4),

	.RCLK(RCLK),
	.RDATA(RDATA),
	.RVALID(RVALID),
	.RREADY(RREADY)
);

endmodule
