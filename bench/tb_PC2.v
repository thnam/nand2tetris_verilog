`timescale 1ns/100ps
`define IVERILOG 1

module tb_PC2;
   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [WIDTH-1:0]     out;                    // From uut of PC.v
   // End of automatics
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg                  clk;                    // To uut of PC.v
   reg [WIDTH-1:0]      in;                     // To uut of PC.v
   reg                  inc;                    // To uut of PC.v
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
        .inc                            (inc),
        .in                             (in[WIDTH-1:0]));

   localparam T = 31.25; // clock cycle is 31.25 ticks
   localparam WIDTH = 16;
   reg [34:0]           testvectors[100:0];
   reg [31:0]           vectornum, errors;
   reg [WIDTH-1:0] expOut;
   // setup dump and reset
   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);

      $readmemb("bench/pc-test.txt", testvectors);
      vectornum = 0; errors = 0;
      reset = 1;
      clk = 0;
   end

   always #(T/2) clk = ~clk;


   // other stimulus
   always @(negedge clk) begin
      #1
      {in, reset, load, inc, expOut} <= testvectors[vectornum];
   end

   always @(posedge clk) begin
      #1
      // $display("line %d: in %b, reset %b, load %b, inc %b, out %b, expOut %b",
         // {vectornum}, {in}, {reset}, {load}, {inc}, {out}, {expOut});
      if ((expOut !== out)) begin
         $display("Error at %d, inputs = in %b, load %b, ", {vectornum}, {in}, {load});
         $display(", out = %b (expected %b)", {out}, {expOut});
         errors = errors + 1;
      end
      if (testvectors[vectornum] === 35'bx) begin
         $display ("%d tests completed with %d errors", vectornum, errors);
         $finish;
      end
      vectornum = vectornum + 1;
   end
endmodule // end of tb_PC

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
