// Design: Synchronous Counter
module synchronous_counter(
    input clk,
    input reset,
    output reg [3:0] q
);
always @(posedge clk) begin
    if (reset)
        q <= 4'b0000;
    else
        q <= q + 1'b1;
end
endmodule

// Testbench
module tb_synchronous_counter;
reg clk, reset;
wire [3:0] q;
synchronous_counter uut (
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
    #180;
    $finish;
end
initial begin
    $monitor("Time=%0t reset=%b q=%d", $time, reset, q);
end
endmodule