Code
// Design: 4-bit ALU
module ALU(
    input [3:0] A, B,
    input [2:0] sel,
    output reg [3:0] Y
);
always @(*) begin
    case (sel)
        3'b000: Y = A + B;
        3'b001: Y = A - B;
        3'b010: Y = A & B;
        3'b011: Y = A | B;
        3'b100: Y = A ^ B;
        3'b101: Y = ~A;
        3'b110: Y = A << 1;
        3'b111: Y = A >> 1;
        default: Y = 4'b0000;
    endcase
end
endmodule

// Testbench
module tb_ALU;
reg [3:0] A, B;
reg [2:0] sel;
wire [3:0] Y;
ALU uut (
    .A(A),
    .B(B),

    .sel(sel),
    .Y(Y)
);
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    A = 4'b0101;
    B = 4'b0011;
    sel = 3'b000; #10;
    sel = 3'b001; #10;
    sel = 3'b010; #10;
    sel = 3'b011; #10;
    sel = 3'b100; #10;
    sel = 3'b101; #10;
    sel = 3'b110; #10;
    sel = 3'b111; #10;
    $finish;
end
initial begin
    $monitor("Time=%0t A=%b B=%b sel=%b Y=%b",
             $time, A, B, sel, Y);
end
endmodule