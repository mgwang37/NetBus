/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 08/12/2020 09:00:52 AM
** Design Name:
** Module Name: NetBusTx7
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

module NetBusTx7#(
	parameter  DATA_WIDTH = 4
)(
	input                        CLK,
	input    [DATA_WIDTH*9+13:0] DATA,
    input                        VALID,
    output                       READY,

	output                       WCLK0,
	output   [DATA_WIDTH*9+13:0] WDATA0,
    output                       WVALID0,
    input                        WREADY0,

	output                       WCLK1,
	output   [DATA_WIDTH*9+13:0] WDATA1,
    output                       WVALID1,
    input                        WREADY1,

	output                       WCLK2,
	output   [DATA_WIDTH*9+13:0] WDATA2,
    output                       WVALID2,
    input                        WREADY2,

	output                       WCLK3,
	output   [DATA_WIDTH*9+13:0] WDATA3,
    output                       WVALID3,
    input                        WREADY3,

	output                       WCLK4,
	output   [DATA_WIDTH*9+13:0] WDATA4,
    output                       WVALID4,
    input                        WREADY4,

	output                       WCLK5,
	output   [DATA_WIDTH*9+13:0] WDATA5,
    output                       WVALID5,
    input                        WREADY5,

	output                       WCLK6,
	output   [DATA_WIDTH*9+13:0] WDATA6,
    output                       WVALID6,
    input                        WREADY6
);

assign WCLK0 = CLK;
assign WCLK1 = CLK;
assign WCLK2 = CLK;
assign WCLK3 = CLK;
assign WCLK4 = CLK;
assign WCLK5 = CLK;
assign WCLK6 = CLK;

assign WDATA0 = DATA;
assign WDATA1 = DATA;
assign WDATA2 = DATA;
assign WDATA3 = DATA;
assign WDATA4 = DATA;
assign WDATA5 = DATA;
assign WDATA6 = DATA;

assign WVALID0 = VALID;
assign WVALID1 = VALID;
assign WVALID2 = VALID;
assign WVALID3 = VALID;
assign WVALID4 = VALID;
assign WVALID5 = VALID;
assign WVALID6 = VALID;

assign READY  = WREADY0 | WREADY1 | WREADY2 | WREADY3 | WREADY4 | WREADY5 | WREADY6;

endmodule
