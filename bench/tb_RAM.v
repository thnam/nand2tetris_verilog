`timescale 1ns/100ps
`define IVERILOG 1

module tb_RAM;
   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [WIDTH-1:0]     out;                    // From uut of RAM.v
   // End of automatics
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [DEPTH-1:0]      address;                // To uut of RAM.v
   reg                  clk;                    // To uut of RAM.v
   reg [WIDTH-1:0]      in;                     // To uut of RAM.v
   reg                  load;                   // To uut of RAM.v
   // End of automatics

   RAM #(/*autoinstparam*/
         // Parameters
         .WIDTH                         (WIDTH),
         .DEPTH                         (DEPTH)) 
   uut (/*autoinst*/
        // Outputs
        .out                            (out[WIDTH-1:0]),
        // Inputs
        .clk                            (clk),
        .load                           (load),
        .address                        (address[DEPTH-1:0]),
        .in                             (in[WIDTH-1:0]));

   localparam T = 31.25; // clock cycle is 31.25 ticks
   localparam DEPTH = 3, WIDTH = 16;
   // setup dump and reset
   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);

      clk = 1'b1;
   end

   // clocking
   always #(T/2) clk = ~clk;

   // when to finish
   initial #400 $finish; // finish at 200 ticks

   // other stimulus
   initial begin
      // init values
      load = 0;
      in = 0;
      address = 0;
      // wait for negedge of reset and 1 clock
      @(negedge clk);
      // change values
      address = 3'b000;
      @(negedge clk);
      in = 16'h1234;
      load = 1;
      @(negedge clk);

      in = in + 2;
      address = 3'b001;
      @(negedge clk);

      in = in + 2;
      address = 3'b010;
      @(negedge clk);

      load = 0;
      @(negedge clk);
      address = 3'b000;

      @(negedge clk);
      address = 3'b001;
      @(negedge clk);
      address = 3'b010;
      @(negedge clk);
      address = 3'b011;
   end
endmodule // end of tb_RAM

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
