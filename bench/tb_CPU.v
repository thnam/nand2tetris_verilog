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
   // setup dump and reset
   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);

      clk = 1'b1;
      reset = 1'b1;
      #(T/2) reset = 1'b0;
   end

   // clocking
   always #(T/2) clk = ~clk;

   // when to finish
   initial #1000 $finish; // finish at 100000 ticks

   // other stimulus
   initial begin
      // init values
      inM = 0; instruction = 0;
      // wait for negedge of reset and 1 clock
      @(negedge reset);
      @(negedge clk);
      // change values

      instruction = 16'b0011000000111001; // @12345
      @(negedge clk);
instruction = 16'b1110110000010000; // D=A
      @(negedge clk);
instruction = 16'b0101101110100000; // @23456
      @(negedge clk);
instruction = 16'b1110000111010000; // D=A-D
      @(negedge clk);
instruction = 16'b0000001111101000; // @1000
      @(negedge clk);
instruction = 16'b1110001100001000; // M=D
      @(negedge clk);
instruction = 16'b0000001111101001; // @1001
      @(negedge clk);
   end
endmodule // end of tb_CPU

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
