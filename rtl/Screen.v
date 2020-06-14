`default_nettype none
module Screen(
   input wire clk,
   input wire load,
   input wire [12:0] address,
   input wire [15:0] in,
   output wire [15:0] out
);

RAM #(/*autoinstparam*/
   // Parameters
   .WIDTH                            (16),
   .DEPTH                            (13)) 
screen8k (/*autoinst*/
   // Outputs
   .out                 (out),
   // Inputs
   .clk                 (clk),
   .load                (load),
   .address             (address),
   .in                  (in));
endmodule
// Local Variables:
// verilog-library-directories:(".." "../modules" ".")
// End:
