`default_nettype none
module Reg #(parameter WIDTH=16) (
   input wire clk, load,
   input wire [WIDTH-1:0] d,
   output reg [WIDTH-1:0] q);

always @(posedge clk)
   if (load)
      q <= d;

endmodule
