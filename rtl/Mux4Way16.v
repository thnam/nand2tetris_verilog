`default_nettype none
module Mux4Way16(
   input wire [15:0] a,
   input wire [15:0] b,
   input wire [15:0] c,
   input wire [15:0] d,
   input wire [1:0] sel,
   output wire [15:0] out
);

assign out = sel[1] ? (sel[0] ? d:c) : (sel[0] ? b:a);
endmodule
// Local Variables:
// verilog-library-directories:(".." "./rtl" ".")
// End:
