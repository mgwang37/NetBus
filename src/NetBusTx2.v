/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 08/12/2020 09:00:52 AM
** Design Name:
** Module Name: NetBusTx2
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

module NetBusTx2#(
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
    input                        WREADY1
);

assign WCLK0 = CLK;
assign WCLK1 = CLK;

assign WDATA0 = DATA;
assign WDATA1 = DATA;

assign WVALID0 = VALID;
assign WVALID1 = VALID;

assign READY  = WREADY0 | WREADY1;

endmodule
