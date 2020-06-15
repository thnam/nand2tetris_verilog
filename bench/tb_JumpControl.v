`timescale 1ns/1ps
`define IVERILOG 1

module tb_JumpControl;
   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 jmp;                    // From uut of JumpControl.v
   wire                 noJmp;                  // From uut of JumpControl.v
   // End of automatics
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg                  jmpNeg;                 // To uut of JumpControl.v
   reg                  jmpPos;                 // To uut of JumpControl.v
   reg                  jmpZero;                // To uut of JumpControl.v
   reg                  ng;                     // To uut of JumpControl.v
   reg                  zr;                     // To uut of JumpControl.v
   // End of automatics

   JumpControl #(/*autoinstparam*/) uut (/*autoinst*/
                                         // Outputs
                                         .jmp                   (jmp),
                                         .noJmp                 (noJmp),
                                         // Inputs
                                         .jmpNeg                (jmpNeg),
                                         .jmpZero               (jmpZero),
                                         .jmpPos                (jmpPos),
                                         .ng                    (ng),
                                         .zr                    (zr));

   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);
      {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b00000;
   end
   
   initial begin
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b00001;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b00010;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b00011;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b00100;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b00101;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b00110;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b00111;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b01000;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b01001;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b01010;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b01011;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b01100;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b01101;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b01110;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b01111;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b10000;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b10001;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b10010;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b10011;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b10100;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b10101;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b10110;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b10111;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b11000;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b11001;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b11010;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b11011;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b11100;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b11101;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b11110;
      #10 {jmpNeg, jmpPos, jmpZero, ng, zr} = 5'b11111;
      #10 $finish;

   end

endmodule // end of tb_JumpControl

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
