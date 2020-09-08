/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 08/12/2020 09:00:52 AM
** Design Name:
** Module Name: AsyncInputSync 
** Project Name:  NetBus
** Description:
**
** Dependencies:
**
** Revision:
** Revision 0.01 - File Created
** Additional Comments:
*/

module AsyncInputSync #(
	parameter SYNC_STAGES = 2,
	parameter DATA_WIDTH  = 1
)(
	input                   CLK,
	input  [DATA_WIDTH-1:0] ASYNC_IN,
	output [DATA_WIDTH-1:0] SYNC_OUT
);

genvar i;
generate
	for (i=0; i < DATA_WIDTH; i=i+1)
	begin: data

		(* ASYNC_REG="TRUE" *) reg [SYNC_STAGES-1:0] sreg;
		always @(posedge CLK)begin
			sreg <= {sreg[SYNC_STAGES-2:0], ASYNC_IN[i]};
		end
		assign SYNC_OUT[i] = sreg[SYNC_STAGES-1];
	end
endgenerate

endmodule
