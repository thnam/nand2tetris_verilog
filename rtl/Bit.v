`default_nettype none
module Bit(
   input wire clk,
   input wire in,
   input wire load,
   output reg out
);
always @(posedge clk) begin
   if (load)
      out <= in;
end
endmodule
// Local Variables:
// verilog-library-directories:(".." "../modules" ".")
// End:
