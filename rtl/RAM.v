`default_nettype none
module RAM #(
   parameter WIDTH=16, // number of bits
   DEPTH=3  // number of address bits
)
(
   input wire clk,
   input wire load,
   input wire [DEPTH-1:0] address,
   input wire [WIDTH-1:0] in,
   output reg [WIDTH-1:0] out
);

// signal declaration
reg [WIDTH-1:0] array_reg [2**DEPTH-1:0];

// assign out = array_reg[address]; // this set output right when the address
// changes, regardless of clock edge -> not the correct behavior

integer i;
initial begin
  for (i = 0; i < 2**DEPTH; i = i + 1)
     array_reg[i] = 0;
end

always @(posedge clk) begin
   out <= array_reg[address];
   if (load)
      array_reg[address] <= in;
end

endmodule
