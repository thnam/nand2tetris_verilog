module ROM32K (
  input wire clk,
  input wire [14:0] address,
  output reg [15:0] out
);

reg [15:0] mem [2**15 - 1:0];

initial begin
   $readmemb("rtl/rom_content.txt", mem, 0, 2**15 - 1);
end

always @(posedge clk) begin
   out <= mem[address];
end

endmodule
// Local Variables:
// verilog-library-directories:(".." "../modules" ".")
// End:
