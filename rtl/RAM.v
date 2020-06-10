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
   output wire [WIDTH-1:0] out
);

// signal declaration
reg [WIDTH-1:0] array_reg [2**DEPTH-1:0];

assign out = array_reg[address];

integer i;
initial begin
  for (i = 0; i < 2**DEPTH; i = i + 1)
     array_reg[i] = 0;
end

always @(posedge clk) begin
   if (load)
      array_reg[address] <= in;
end

endmodule
