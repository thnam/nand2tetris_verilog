`default_nettype none

module PC #(parameter WIDTH=16)(
  input wire clk,
  input wire load,
  input wire reset,
  input wire inc,
  input wire [WIDTH-1:0] in,
  output wire [WIDTH-1:0] out
);

reg [WIDTH-1:0] obuff;
assign out = obuff;

always @(posedge clk ) begin
   if (reset) begin
      obuff <= 0;
   end else begin
      if (load)
         obuff <= in;
      else if (inc)
         obuff <= obuff + 1;
   end
end
endmodule
// Local Variables:
// verilog-library-directories:(".." "../modules" ".")
// End:
