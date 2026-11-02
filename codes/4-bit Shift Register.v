// Design: 4-bit Shift Register
module shift_register(
    input clk,
    input reset,
    input serial_in,
    output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0000;
    else
        q <= {q[2:0], serial_in};
end
endmodule

// Testbench
module tb_shift_register;
reg clk, reset, serial_in;
wire [3:0] q;
shift_register uut (
    .clk(clk),
    .reset(reset),
    .serial_in(serial_in),
    .q(q)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    clk = 0;
    reset = 1;

    serial_in = 0;
    #10 reset = 0;
    serial_in = 1; #10;
    serial_in = 0; #10;
    serial_in = 1; #10;
    serial_in = 1; #10;
    serial_in = 0; #10;
    #20;
    $finish;
end
initial begin
    $monitor("Time=%0t serial_in=%b q=%b",
             $time, serial_in, q);
end
endmodule