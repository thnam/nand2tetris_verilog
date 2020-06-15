`timescale 1ns/100ps
`define IVERILOG 1

module tb_Computer;
   /*autowire*/
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg                  clk;                    // To uut of Computer.v
   reg [15:0]           kbIn;                   // To uut of Computer.v
   reg                  reset;                  // To uut of Computer.v
   // End of automatics

   Computer #(/*autoinstparam*/) 
   uut (/*autoinst*/
        // Inputs
        .clk                            (clk),
        .reset                          (reset),
        .kbIn                           (kbIn[15:0]));

   localparam T = 31.25; // clock cycle is 31.25 ticks
   // setup dump and reset
   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);

      kbIn = 0;
      clk = 1'b1;
      reset = 1'b1;
      #(T/2) reset = 1'b0;
   end

   // clocking
   always #(T/2) clk = ~clk;

   // when to finish
   initial #1000 $finish; // finish at 10000 ticks

endmodule // end of tb_Computer

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
