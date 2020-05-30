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
   reg reset;

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
   localparam DEPTH = 2, WIDTH = 8;
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
   initial #10000 $finish; // finish at 10000 ticks

   task write;
      begin
         @(negedge clk);
         load = 1;
         in = in + 1;
         address = address + 1;
         @(negedge clk);
         load = 0;
      end
   endtask
   // other stimulus
   initial begin
      // init values
      load = 0;
      address = 0;
      in = 0;
      // wait for negedge of reset and 1 clock
      @(negedge reset);
      @(negedge clk);
      // change values
      load = 1;
      in = in + 1;
      @(negedge clk);
      load = 0;
      repeat (3) write();
      
   end
endmodule // end of tb_RAM

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
