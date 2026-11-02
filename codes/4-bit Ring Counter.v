// Design: 4-bit Ring Counter
module ring_counter(
    input clk,
    input reset,
    output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0001;
    else
        q <= {q[2:0], q[3]};
end
endmodule

// Testbench
module tb_ring_counter;
reg clk, reset;
wire [3:0] q;
ring_counter uut (
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
    #100;

    $finish;
end
initial begin
    $monitor("Time=%0t Reset=%b Q=%b",
             $time, reset, q);
end
endmodule