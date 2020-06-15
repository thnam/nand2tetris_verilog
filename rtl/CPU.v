module CPU(
   input wire clk,
   input wire [15:0] inM,
   input wire [15:0] instruction,
   input wire reset,

   output wire [15:0] outM,
   output wire writeM,
   output wire [14:0] addressM,
   output wire [14:0] pc
);

localparam WIDTH = 16;
wire AorM, zx, nx, zy, ny, f, no, loadM, loadD, loadA, jmpPos, jmpZero, jmpNeg, Atype;
wire ng, zr, jmp, noJmp;
wire [15:0] A, D, y, outALU;
assign y = AorM ? inM : A;
assign outM = outALU;
assign writeM = loadM;
assign addressM = A[14:0];

// instruction decoder
InstructionDecoder instDecode (/*autoinst*/
   // Outputs
   .AorM            (AorM),
   .zx              (zx),
   .nx              (nx),
   .zy              (zy),
   .ny              (ny),
   .f               (f),
   .no              (no),
   .loadM           (loadM),
   .loadD           (loadD),
   .loadA           (loadA),
   .jmpPos          (jmpPos),
   .jmpZero         (jmpZero),
   .jmpNeg          (jmpNeg),
   .Atype           (Atype),
   // Inputs
   .instruction     (instruction[15:0]));

JumpControl jump (/*autoinst*/
   // Outputs
   .jmp                  (jmp),
   .noJmp                (noJmp),
   // Inputs
   .jmpNeg               (jmpNeg),
   .jmpZero              (jmpZero),
   .jmpPos               (jmpPos),
   .ng                   (ng),
   .zr                   (zr));

ALU alu (/*autoinst*/
   // Outputs
   .out                           (outALU[15:0]),
   .zr                            (zr),
   .ng                            (ng),
   // Inputs
   .x                             (D[15:0]),
   .y                             (y[15:0]),
   .zx                            (zx),
   .zy                            (zy),
   .nx                            (nx),
   .ny                            (ny),
   .f                             (f),
   .no                            (no));

wire [15:0] pcOut;
assign pc = pcOut[14:0];

PC #(.WIDTH(16)) pcounter (/*autoinst*/
   // Outputs
   .out                             (pcOut[WIDTH-1:0]),
   // Inputs
   .clk                             (clk),
   .load                            (jmp),
   .reset                           (reset),
   .inc                             (noJmp),
   .in                              (A[WIDTH-1:0]));

wire [15:0] ARegIn;
assign ARegIn = Atype ? instruction : outALU;
wire loadAReg;
assign loadAReg = loadA | Atype;

Reg #(.WIDTH(16)) AReg (/*autoinst*/
   // Outputs
   .q                            (A[WIDTH-1:0]),
   // Inputs
   .clk                          (clk),
   .load                         (loadAReg),
   .d                            (ARegIn[WIDTH-1:0]));

Reg #(.WIDTH(16)) DReg (/*autoinst*/
   // Outputs
   .q                            (D[WIDTH-1:0]),
   // Inputs
   .clk                          (clk),
   .load                         (loadD),
   .d                            (outALU[WIDTH-1:0]));

endmodule
// Local Variables:
// verilog-library-directories:(".." "./rtl" ".")
// End:
