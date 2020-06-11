`timescale 1ns/100ps
`define IVERILOG 1

module tb_ROM32K;
   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [15:0]          out;                    // From uut of ROM32K.v
   // End of automatics
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [14:0]           address;                // To uut of ROM32K.v
   reg                  clk;                    // To uut of ROM32K.v
   // End of automatics

   ROM32K #(/*autoinstparam*/) 
   uut (/*autoinst*/
        // Outputs
        .out                            (out[15:0]),
        // Inputs
        .clk                            (clk),
        .address                        (address[14:0]));

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
   initial #2000 $finish; // finish at 1000 ticks

   integer i;
   // other stimulus
   initial begin
      // init values
      address = 0;
      // wait for negedge of reset and 1 clock
      @(negedge clk);
      // change values
      for (i = 0; i < 10; i = i + 1) begin
         address <= address + 1;
         @(negedge clk);
      end

      address = 15'b111_1111_1111_1111;
      for (i = 0; i < 10; i = i + 1) begin
         address <= address - 1;
         @(negedge clk);
      end
   end
endmodule // end of tb_ROM32K

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
