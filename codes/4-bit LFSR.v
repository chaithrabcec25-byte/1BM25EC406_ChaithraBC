// 4-bit LFSR
module random_sequence_generator(
    input clk,
    input reset,
    output reg [3:0] q
);
wire feedback;
assign feedback = q[3] ^ q[2];
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0001;
    else
        q <= {q[2:0], feedback};
end
endmodule

// Testbench
module tb_random_sequence_generator;
reg clk, reset;
wire [3:0] q;
random_sequence_generator uut (
    .clk(clk),
    .reset(reset),
    .q(q)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    clk = 0;
    reset = 1;

    #10 reset = 0;
    #200;
    $finish;
end
initial begin
    $monitor("Time=%0t q=%b", $time, q);
end
endmodule  