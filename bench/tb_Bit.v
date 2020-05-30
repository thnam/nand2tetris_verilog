`timescale 1ns/100ps
`define IVERILOG 1

module tb_Bit;
   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 out;                    // From uut of Bit.v
   // End of automatics
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg                  clk;                    // To uut of Bit.v
   reg                  in;                     // To uut of Bit.v
   reg                  load;                   // To uut of Bit.v
   reg reset;
   // End of automatics

   Bit #(/*autoinstparam*/) 
   uut (/*autoinst*/
        // Outputs
        .out                            (out),
        // Inputs
        .clk                            (clk),
        .in                             (in),
        .load                           (load));

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
   initial #1000 $finish; // finish at 1000 ticks

   // other stimulus
   initial begin
      // init values
      load = 0;
      in = 0;
      // wait for negedge of reset and 1 clock
      @(negedge clk);
      in = 1;
      @(negedge clk);
      load = 1;
      in = 0;
      @(negedge clk);
      load = 1;
      in = 1;
   end
endmodule // end of tb_Bit

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
