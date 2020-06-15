module JumpControl(
   input wire jmpNeg, jmpZero, jmpPos,
   input wire ng, zr,
   output wire jmp, noJmp
);

wire oJmpNeg, oJmpPos, oJmpZero;

assign oJmpPos = jmpPos && (!ng) && (!zr);
assign oJmpNeg = jmpNeg && ng;
assign oJmpZero = jmpZero && zr;

wire doJmp = oJmpPos || oJmpNeg || oJmpZero;
assign jmp = doJmp;
assign noJmp = !doJmp;

endmodule
// Local Variables:
// verilog-library-directories:(".." "./rtl" ".")
// End:
