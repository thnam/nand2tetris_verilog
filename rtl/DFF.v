`default_nettype none
module DFF (
   input wire clk,
   input wire in,
   output reg out
);

always @(posedge clk)
   out <= in;

endmodule
