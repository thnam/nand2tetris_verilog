`timescale 1ns/100ps
`define IVERILOG 1

module tb_CPU;
   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [14:0]          addressM;               // From uut of CPU.v
   wire [15:0]          outM;                   // From uut of CPU.v
   wire [14:0]          pc;                     // From uut of CPU.v
   wire                 writeM;                 // From uut of CPU.v
   // End of automatics
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg                  clk;                    // To uut of CPU.v
   reg [15:0]           inM;                    // To uut of CPU.v
   reg [15:0]           instruction;            // To uut of CPU.v
   reg                  reset;                  // To uut of CPU.v
   // End of automatics

   CPU #(/*autoinstparam*/) 
   uut (/*autoinst*/
        // Outputs
        .outM                           (outM[15:0]),
        .writeM                         (writeM),
        .addressM                       (addressM[14:0]),
        .pc                             (pc[14:0]),
        // Inputs
        .clk                            (clk),
        .inM                            (inM[15:0]),
        .instruction                    (instruction[15:0]),
        .reset                          (reset));

   localparam T = 31.25; // clock cycle is 31.25 ticks
   reg [79:0]           testvectors[200:0];
   reg [10:0]           vectornum, errors;
   reg [14:0]          expAddressM;               
   reg [15:0]          expOutM;                   
   reg [14:0]          expPc;                     
   reg                 expWriteM;                 
   // setup dump and reset
   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);

      clk = 1'b1;
      inM = 0; instruction = 0;
      $readmemb("bench/cpu-test.txt", testvectors);
      vectornum = 0; errors = 0;
   end

   // clocking
   always #(T/2) clk = ~clk;

   // stimulus on negative edges
   always @(negedge clk) begin
      #1;
      {inM, instruction, reset, expOutM, expWriteM, expAddressM, expPc} = testvectors[vectornum];
   end
   
   wire mismatch;
   assign mismatch = (expOutM !== outM) | (expWriteM !== writeM) |
      (expAddressM !== addressM) | (expPc !== pc);

   always @(posedge clk) begin
      #3;
      if (mismatch) begin
         errors = errors + 1;
         $display("%d: inM %d, instruction %d, outM %d (exp %d), writeM %d (exp %d), addrM %d (exp %d), pc %d (exp %d)", vectornum + 1, inM, instruction, outM, expOutM, writeM, expWriteM,
         addressM, expAddressM, pc, expPc);
      end

      if (testvectors[vectornum] === 80'bx) begin
         $display ("%d tests completed with %d errors", vectornum, errors);
         $finish;
      end
      vectornum= vectornum+ 1;
   end
endmodule // end of tb_CPU

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
