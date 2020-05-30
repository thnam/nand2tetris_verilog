`default_nettype none
module Reg #(parameter WIDTH=16) (
   input wire clk, reset,
   input wire [WIDTH-1:0] d,
   output reg [WIDTH-1:0] q);

always @(posedge clk, posedge reset)
   if (reset)
      q <= 0;
   else
      q <= d;

endmodule
