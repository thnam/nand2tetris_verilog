`default_nettype none
module Memory(
   input wire clk,
   input wire load,
   input wire [14:0] address,
   input wire [15:0] in,
   input wire [15:0] kbIn,
   output wire [15:0] out
);


// load lower half if address[14] = 0
wire [15:0] ramOut;
RAM #(/*autoinstparam*/
   // Parameters
   .WIDTH                            (16),
   .DEPTH                            (14)) 
ram16k (/*autoinst*/
   // Outputs
   .out                            (ramOut),
   // Inputs
   .clk                            (clk),
   .load                           (load & (~address[14])),
   .address                        (address[13:0]),
   .in                             (in));

// next 8K addresses are for screen
wire [15:0] screenOut;
Screen screen (/*autoinst*/
   // Outputs
   .out                     (screenOut),
   // Inputs
   .clk                     (clk),
   .load                    (load & address[14] & (~address[13])),
   .address                 (address[12:0]),
   .in                      (in[15:0]));

wire [15:0] sk = address[13] ? kbIn : screenOut;
assign out = address[14] ? sk : ramOut;

endmodule
// Local Variables:
// verilog-library-directories:(".." "./rtl" ".")
// End:
