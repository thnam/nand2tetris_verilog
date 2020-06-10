`define IVERILOG 1
`timescale 10ns/1ns

module aluTB;
   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 ng;                     // From aluUUT of ALU.v
   wire [15:0]          out;                    // From aluUUT of ALU.v
   wire                 zr;                     // From aluUUT of ALU.v
   // End of automatics
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg                  f;                      // To aluUUT of ALU.v
   reg                  no;                     // To aluUUT of ALU.v
   reg                  nx;                     // To aluUUT of ALU.v
   reg                  ny;                     // To aluUUT of ALU.v
   reg [15:0]           x;                      // To aluUUT of ALU.v
   reg [15:0]           y;                      // To aluUUT of ALU.v
   reg                  zx;                     // To aluUUT of ALU.v
   reg                  zy;                     // To aluUUT of ALU.v
   // End of automatics

   ALU uut(/*autoinst*/
      // Outputs
      .out                      (out[15:0]),
      .zr                       (zr),
      .ng                       (ng),
      // Inputs
      .x                        (x[15:0]),
      .y                        (y[15:0]),
      .zx                       (zx),
      .zy                       (zy),
      .nx                       (nx),
      .ny                       (ny),
      .f                        (f),
      .no                       (no));

   reg [55:0]           testvectors[20000:0];
   reg [31:0]           vectornum, errors;
   reg                  clk;
   reg                  reset;
   reg [15:0]           expOut;
   reg                  expZr;
   reg                  expNg;


   always begin
      clk = 1'b1;
      #5;
      clk = 1'b0;
      #5;
   end

   initial begin
      $dumpfile("build/waveform.vcd");
      $dumpvars(0, uut);

      // Put test code here
      $readmemb("bench/alu-test-vectors.txt", testvectors);
      vectornum = 0; errors = 0;
      reset = 1; #27; reset = 0;
   end

   always @(posedge clk) begin
      if (~reset) begin
         #1;
         {x,y,zx,nx,zy,ny,f,no,expOut,expZr,expNg} = testvectors[vectornum];
      end
   end

   always @(negedge clk) begin
      if (~reset) begin
         if ((expOut !== out) | (expZr !== zr) | (expNg !==ng)) begin
            $display("Error, inputs = %b", {x,y,zx,nx,zy,ny,f,no});
            $display(", out = %d (expected %d)", {out, zr, ng}, {expOut, expZr, expNg});
            errors = errors + 1;
         end

         vectornum= vectornum+ 1;

         if (testvectors[vectornum] === 56'bx) begin
            $display ("%d tests completed with %d errors", vectornum, errors);

            $finish;
         end
      end
   end

endmodule // end of aluTB

// Local Variables:
// verilog-library-directories:(".." "../rtl")
// End:
