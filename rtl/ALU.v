`default_nettype none
module ALU (/*autoarg*/
   input wire [15:0] x,
   input wire [15:0] y,
   input wire        zx,
   input wire        zy,
   input wire        nx,
   input wire        ny,
   input wire        f,
   input wire        no,
   output wire [15:0] out,
   output wire        zr,
   output wire        ng
);

// Preprocessing x and y
wire [15:0]        x1 = zx ? 16'b0 : x;
wire [15:0]        x2 = nx ? ~x1 : x1;

wire [15:0]        y1 = zy ? 16'b0 : y;
wire [15:0]        y2 = ny ? ~y1 : y1;
// operations
wire [15:0]        addXY = x2 + y2;
wire [15:0]        andXY = x2 & y2;
wire [15:0]        retF = f ? addXY : andXY;

assign out = no ? ~retF : retF;
assign zr = (out[15:0] == 16'b0);
assign ng = out[15];

endmodule // end of module ALU

