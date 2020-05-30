`default_nettype none
module RAM
   #(
      parameter WIDTH=8, // number of bits
      DEPTH=2  // number of address bits
   )
   (
      input wire clk,
      input wire load,
      input wire [DEPTH-1:0] address,
      input wire [WIDTH-1:0] in,
      output wire [WIDTH-1:0] out
   );

// signal declaration
reg [WIDTH-1:0] array_reg [2**WIDTH-1:0];

always @(posedge clk)
   if (load)
      array_reg[address] <= in;

assign out = array_reg[address];

endmodule
