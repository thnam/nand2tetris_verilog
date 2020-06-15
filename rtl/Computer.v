module Computer(
   input wire clk,
   input wire reset,
   input wire [15:0] kbIn
);

wire [15:0] instruction, outM, inM;
wire [14:0] pc, addressM;
wire writeM;

ROM32K rom (/*autoinst*/
   // Outputs
   .out                        (instruction[15:0]),
   // Inputs
   .clk                        (clk),
   .address                    (pc[14:0]));

CPU cpu (/*autoinst*/
   // Outputs
   .outM                          (outM[15:0]),
   .writeM                        (writeM),
   .addressM                      (addressM[14:0]),
   .pc                            (pc[14:0]),
   // Inputs
   .clk                           (clk),
   .inM                           (inM[15:0]),
   .instruction                   (instruction[15:0]),
   .reset                         (reset));

Memory ram (/*autoinst*/
   // Outputs
   .out                        (inM[15:0]),
   // Inputs
   .clk                        (clk),
   .load                       (writeM),
   .address                    (addressM[14:0]),
   .in                         (outM[15:0]),
   .kbIn                       (kbIn[15:0]));

endmodule
// Local Variables:
// verilog-library-directories:(".." "./rtl" ".")
// End:
