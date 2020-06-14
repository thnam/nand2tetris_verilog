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
   reg [64:0]           testvectors[200:0];
   reg [10:0]           vectornum, errors;
   reg [15:0] expOut;
   // setup dump and reset
   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);

      clk = 1'b1;
      in = 0; load = 0; address = 0; kbIn = 0;

      $readmemb("bench/mem-test.txt", testvectors);
      vectornum = 0; errors = 0;
   end

   // clocking
   always #(T/2) clk = ~clk;

   // other stimulus
   always @(negedge clk) begin
      #2;
      {in, load, address, kbIn, expOut} = testvectors[vectornum];
   end

   always @(posedge clk) begin
      #2
      if ((expOut !== out)) begin
         $display("Error at line %d, inputs = in %x, load %x, address %x, out %x (expected %x)",
            {vectornum}, {in}, {load}, {address}, {out}, {expOut});
         errors = errors + 1;
      end
      if (testvectors[vectornum] === 65'bx) begin
         $display ("%d tests completed with %d errors", vectornum, errors);
         $finish;
      end
      vectornum= vectornum+ 1;
   end
endmodule // end of tb_Memory

// Local Variables:
// verilog-library-directories:(".." "../rtl" ".")
// End:
