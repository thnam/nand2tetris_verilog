`default_nettype none
module Bit(
   input wire clk,
   input wire load,
   input wire d,
   output reg q
);
always @(posedge clk) begin
   if (d)
      q <= d;
end
endmodule
// Local Variables:
// verilog-library-directories:(".." "../modules" ".")
// End:
