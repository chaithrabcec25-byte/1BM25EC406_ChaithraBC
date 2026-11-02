// Design: 4-bit Comparator
module comparator(
    input [3:0] A, B,
    output reg greater,
    output reg equal,
    output reg less
);
always @(*) begin
    greater = 0;
    equal = 0;
    less = 0;
    if (A > B)
        greater = 1;
    else if (A == B)
        equal = 1;
    else
        less = 1;
end
endmodule

// Testbench
module tb_comparator;
reg [3:0] A, B;
wire greater, equal, less;
comparator uut (

    .A(A),
    .B(B),
    .greater(greater),
    .equal(equal),
    .less(less)
);
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    A = 4'd9; B = 4'd5; #10;
    A = 4'd4; B = 4'd4; #10;
    A = 4'd2; B = 4'd7; #10;
    $finish;
end
initial begin
    $monitor("Time=%0t A=%d B=%d Greater=%b Equal=%b Less=%b",
             $time, A, B, greater, equal, less);
end
endmodule