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
   reg [35:0]           testvectors[200:0];
   reg [10:0]           vectornum, errors;
   reg [WIDTH-1:0] expOut;
   // setup dump and reset
   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);

      clk = 1'b0;
      in = 0; load = 0; address = 0;

      $readmemb("bench/ram-test.txt", testvectors);
      vectornum = 0; errors = 0;
   end

   // clocking
   always #(T/2) clk = ~clk;

   // other stimulus
   always @(negedge clk) begin
      #1;
      {in, load, address, expOut} = testvectors[vectornum];
   end

   always @(posedge clk) begin
      #1
      if ((expOut !== out)) begin
         $display("Error at line %d, inputs = in %b, load %b, address %b, out %b (expected %b)",
            {vectornum}, {in}, {load}, {address}, {out}, {expOut});
         errors = errors + 1;
      end
      if (testvectors[vectornum] === 36'bx) begin
         $display ("%d tests completed with %d errors", vectornum, errors);
         $finish;
      end
      vectornum= vectornum+ 1;
   end
endmodule // end of tb_RAM

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
