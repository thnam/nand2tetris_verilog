module InstructionDecoder(
   input wire [15:0] instruction,
   output wire AorM, zx, nx, zy, ny, f, no, loadM, loadD, loadA, jmpPos, jmpZero, jmpNeg
);

reg [14:0] c_instruction;
always @(*) begin
   if (~instruction[15]) begin
      c_instruction = 0;
   end
   else begin
      c_instruction = instruction[14:0];
   end
end

assign AorM = c_instruction[12];
assign {zx, nx, zy, ny, f, no} = instruction[15] ? instruction[11:6] : 6'b111111;
assign {loadA, loadD, loadM} = c_instruction[5:3];
assign {jmpNeg, jmpZero, jmpPos} = c_instruction[2:0];

endmodule
// Local Variables:
// verilog-library-directories:(".." "./rtl" ".")
// End:
