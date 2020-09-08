/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 08/12/2020 09:00:52 AM
** Design Name:
** Module Name: NetBusRx4
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

module NetBusRx4#(
    parameter  DATA_WIDTH = 4,
	parameter  PORT_ROUTE  = 32'h00000000,
    parameter  FIFO_DEPTH  = 4,
    parameter  SYNC_STAGES = 2,
    parameter  REAL_TIME_PORT0 = 0,
    parameter  REAL_TIME_PORT1 = 0,
    parameter  REAL_TIME_PORT2 = 0,
    parameter  REAL_TIME_PORT3 = 0
)(
	input                          RESETn,

    input                          RCLK0,
    input    [DATA_WIDTH*9+13:0]   RDATA0,
    input                          RVALID0,
    output                         RREADY0,

    input                          RCLK1,
    input    [DATA_WIDTH*9+13:0]   RDATA1,
    input                          RVALID1,
    output                         RREADY1,

    input                          RCLK2,
    input    [DATA_WIDTH*9+13:0]   RDATA2,
    input                          RVALID2,
    output                         RREADY2,

    input                          RCLK3,
    input    [DATA_WIDTH*9+13:0]   RDATA3,
    input                          RVALID3,
    output                         RREADY3,

    input                          RCLK,
    output reg [DATA_WIDTH*9+13:0] RDATA,
    output reg                     RVALID,
    input                          RREADY
);

wire [DATA_WIDTH*9+13:0] rdata0;
wire                     rvalid0;
reg                      rready0;
wire                     rframe0;
wire                     r_ok0;
assign r_ok0 = REAL_TIME_PORT0 ? rvalid0 : rframe0 ;

NetBusSliceRx#(
	.DATA_WIDTH(DATA_WIDTH),
	.PORT_ROUTE(PORT_ROUTE),
	.FIFO_DEPTH(FIFO_DEPTH),
	.SYNC_STAGES(SYNC_STAGES)
)chanel_0(
	.RESETn(RESETn),

	.WCLK(RCLK0),
	.WDATA(RDATA0),
	.WVALID(RVALID0),
	.WREADY(RREADY0),

	.RCLK(RCLK),
	.RDATA(rdata0),
	.RVALID(rvalid0),
	.RREADY(rready0),
	.RFRAME(rframe0)
);


wire [DATA_WIDTH*9+13:0] rdata1;
wire                     rvalid1;
reg                      rready1;
wire                     rframe1;
wire                     r_ok1;
assign r_ok1 = REAL_TIME_PORT1 ? rvalid1 : rframe1 ;

NetBusSliceRx#(
	.DATA_WIDTH(DATA_WIDTH),
	.PORT_ROUTE(PORT_ROUTE),
	.FIFO_DEPTH(FIFO_DEPTH),
	.SYNC_STAGES(SYNC_STAGES)
)chanel_1(
	.RESETn(RESETn),

	.WCLK(RCLK1),
	.WDATA(RDATA1),
	.WVALID(RVALID1),
	.WREADY(RREADY1),

	.RCLK(RCLK),
	.RDATA(rdata1),
	.RVALID(rvalid1),
	.RREADY(rready1),
	.RFRAME(rframe1)
);


wire [DATA_WIDTH*9+13:0] rdata2;
wire                     rvalid2;
reg                      rready2;
wire                     rframe2;
wire                     r_ok2;
assign r_ok2 = REAL_TIME_PORT2 ? rvalid2 : rframe2 ;

NetBusSliceRx#(
	.DATA_WIDTH(DATA_WIDTH),
	.PORT_ROUTE(PORT_ROUTE),
	.FIFO_DEPTH(FIFO_DEPTH),
	.SYNC_STAGES(SYNC_STAGES)
)chanel_2(
	.RESETn(RESETn),

	.WCLK(RCLK2),
	.WDATA(RDATA2),
	.WVALID(RVALID2),
	.WREADY(RREADY2),

	.RCLK(RCLK),
	.RDATA(rdata2),
	.RVALID(rvalid2),
	.RREADY(rready2),
	.RFRAME(rframe2)
);


wire [DATA_WIDTH*9+13:0] rdata3;
wire                     rvalid3;
reg                      rready3;
wire                     rframe3;
wire                     r_ok3;
assign r_ok3 = REAL_TIME_PORT3 ? rvalid3 : rframe3 ;

NetBusSliceRx#(
	.DATA_WIDTH(DATA_WIDTH),
	.PORT_ROUTE(PORT_ROUTE),
	.FIFO_DEPTH(FIFO_DEPTH),
	.SYNC_STAGES(SYNC_STAGES)
)chanel_3(
	.RESETn(RESETn),

	.WCLK(RCLK3),
	.WDATA(RDATA3),
	.WVALID(RVALID3),
	.WREADY(RREADY3),

	.RCLK(RCLK),
	.RDATA(rdata3),
	.RVALID(rvalid3),
	.RREADY(rready3),
	.RFRAME(rframe3)
);


reg [2:0] port_id;
wire      port_need_switch;
assign    port_need_switch = ((port_id == 4) | (RREADY & RVALID & RDATA[0]));

always @(posedge RCLK or negedge RESETn)begin
	if (!RESETn)begin
		port_id <= 4;
	end else if (port_need_switch)begin
		if (r_ok0)begin
			port_id <= 0;
		end else if (r_ok1)begin
			port_id <= 1;
		end else if (r_ok2)begin
			port_id <= 2;
		end else if (r_ok3)begin
			port_id <= 3;
		end else begin
			port_id <= 4;
		end
	end 
end

always @(*)begin
	case (port_id)
	0:begin
		RDATA = rdata0;
		RVALID = rvalid0;
		rready0 = RREADY;
		rready1 = 1'b0;
		rready2 = 1'b0;
		rready3 = 1'b0;
	  end
	1:begin
		RDATA = rdata1;
		RVALID = rvalid1;
		rready0 = 1'b0;
		rready1 = RREADY;
		rready2 = 1'b0;
		rready3 = 1'b0;
	  end
	2:begin
		RDATA = rdata2;
		RVALID = rvalid2;
		rready0 = 1'b0;
		rready1 = 1'b0;
		rready2 = RREADY;
		rready3 = 1'b0;
	  end
	3:begin
		RDATA = rdata3;
		RVALID = rvalid3;
		rready0 = 1'b0;
		rready1 = 1'b0;
		rready2 = 1'b0;
		rready3 = RREADY;
	  end
	default:
		begin
			RDATA = rdata0;
			RVALID = rvalid0;
			rready0 = RREADY;
			rready1 = 1'b0;
			rready2 = 1'b0;
			rready3 = 1'b0;
		end
	endcase
end

endmodule
