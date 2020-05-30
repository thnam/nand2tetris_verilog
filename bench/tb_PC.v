`timescale 1ns/100ps
`define IVERILOG 1

module tb_PC;
   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [WIDTH-1:0]     out;                    // From uut of PC.v
   // End of automatics
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg                  clk;                    // To uut of PC.v
   reg [WIDTH-1:0]      in;                     // To uut of PC.v
   reg                  load;                   // To uut of PC.v
   reg                  reset;                  // To uut of PC.v
   // End of automatics

   PC #(/*autoinstparam*/
        // Parameters
        .WIDTH                          (WIDTH)) 
   uut (/*autoinst*/
        // Outputs
        .out                            (out[WIDTH-1:0]),
        // Inputs
        .clk                            (clk),
        .load                           (load),
        .reset                          (reset),
        .in                             (in[WIDTH-1:0]));

   localparam T = 31.25; // clock cycle is 31.25 ticks
   localparam WIDTH = 16;
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
   initial #10000 $finish; // finish at 200 ticks

   // other stimulus
   initial begin
      // init values
      load = 0;
      in = 16'h1A2B;
      // wait for negedge of reset and 1 clock
      @(negedge reset);
      @(negedge clk);
      // change values
      repeat (10) @(negedge clk);
      load = 1;
      @(negedge clk);
      load = 0;
      repeat (10) @(negedge clk);
      load = 1;
      @(negedge clk);
      @(negedge clk);
      @(negedge clk);
      load = 0;
      @(negedge clk);
      reset = 1;
      @(negedge clk);
      reset = 0;
      repeat (10) @(negedge clk);
   end
endmodule // end of tb_PC

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
