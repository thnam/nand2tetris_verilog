module PC #(parameter WIDTH=16)(
  input wire clk,
  input wire load,
  input wire reset,
  input wire [WIDTH-1:0] in,
  output wire [WIDTH-1:0] out
);
reg [WIDTH-1:0] counter;
assign out = counter;
always @(posedge clk or posedge reset) begin
   if (reset) begin
      counter <= 0;
   end else begin
      if (load)
         counter <= in;
      else
         counter <= counter + 1;
   end
end
endmodule
// Local Variables:
// verilog-library-directories:(".." "../modules" ".")
// End:
