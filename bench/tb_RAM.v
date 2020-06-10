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
   localparam DEPTH = 2, WIDTH = 16;
   reg [34:0]           testvectors[20000:0];
   reg [31:0]           vectornum, errors;
   reg [WIDTH-1:0] expOut;
   // setup dump and reset
   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);

      clk = 1'b1;
      reset = 1'b1;
      #(T/2) reset = 1'b0;

      $readmemb("bench/ram-test.txt", testvectors);
      vectornum = 0; errors = 0;
   end

   // clocking
   always #(T/2) clk = ~clk;

   // when to finish
   initial #10000 $finish; // finish at 10000 ticks

   // other stimulus
   always @(negedge clk) begin
      #1;
      if (~reset) begin
         {in, load, address, expOut} = testvectors[vectornum];
      end
   end
   always @(posedge clk) begin
      if (~reset)
         if ((expOut !== out)) begin
            $display("Error, inputs = in %b, load %b, address %b", {in}, {load}, {address});
            $display(", out = %b (expected %b)", {out}, {expOut});
            errors = errors + 1;
         end
         if (testvectors[vectornum] === 34'bx) begin
            $display ("%d tests completed with %d errors", vectornum, errors);

            $finish;
         end
         vectornum= vectornum+ 1;
   end
endmodule // end of tb_RAM

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
