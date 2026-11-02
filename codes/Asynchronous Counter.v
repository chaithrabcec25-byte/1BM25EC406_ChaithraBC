// Design: Asynchronous Counter
module asynchronous_counter(
    input clk,
    input reset,
    output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset)
        q[0] <= 1'b0;
    else
        q[0] <= ~q[0];
end
always @(posedge q[0] or posedge reset) begin
    if (reset)
        q[1] <= 1'b0;
    else
        q[1] <= ~q[1];

end
always @(posedge q[1] or posedge reset) begin
    if (reset)
        q[2] <= 1'b0;
    else
        q[2] <= ~q[2];
end
always @(posedge q[2] or posedge reset) begin
    if (reset)
        q[3] <= 1'b0;
    else
        q[3] <= ~q[3];
end
endmodule

// Testbench
module tb_asynchronous_counter;
reg clk, reset;
wire [3:0] q;
asynchronous_counter uut (
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
    #12 reset = 0;
    #200;
    $finish;
end
initial begin
    $monitor("Time=%0t reset=%b q=%d", $time, reset, q);

end
endmodule  