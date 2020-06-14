`timescale 1ns/100ps
`define IVERILOG 1

module tb_Memory;
   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [15:0]          out;                    // From uut of Memory.v
   // End of automatics
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [14:0]           address;                // To uut of Memory.v
   reg                  clk;                    // To uut of Memory.v
   reg [15:0]           in;                     // To uut of Memory.v
   reg [15:0]           kbIn;                   // To uut of Memory.v
   reg                  load;                   // To uut of Memory.v
   // End of automatics

   Memory #(/*autoinstparam*/) 
   uut (/*autoinst*/
        // Outputs
        .out                            (out[15:0]),
        // Inputs
        .clk                            (clk),
        .load                           (load),
        .address                        (address[14:0]),
        .in                             (in[15:0]),
        .kbIn                           (kbIn[15:0]));

   localparam T = 31.25; // clock cycle is 31.25 ticks
   // setup dump and reset
   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);

      clk = 1'b1;
   end

   // clocking
   always #(T/2) clk = ~clk;

   // when to finish
   initial #10000 $finish; // finish at 10000 ticks

   // other stimulus
   initial begin
      // init values
      in = 0;
      address = 0;
      load = 0;
      kbIn = 0;
      // wait for negedge of reset and 1 clock
      @(negedge clk);
      // change values
      in = 16'b1111_1111_1111_1111; load = 1; address = 0;
      @(negedge clk);
      in = 16'd9999; load = 0;
      @(negedge clk);
      address = 16'h2000;
      @(negedge clk);
      address = 16'h4000;
      @(negedge clk);
      address = 16'h4000;
      @(negedge clk);
      in = 16'd2222; load = 1; address = 16'h2000;
      @(negedge clk);
      in = 16'd9999; load = 0;
      @(negedge clk);
      address = 16'h0000;
      @(negedge clk);
      address = 16'h4000;

   end
endmodule // end of tb_Memory

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
