// Design: 4-bit Barrel Shifter
module barrel_shifter(
    input [3:0] data,
    input [1:0] shift,
    input direction,
    output reg [3:0] result
);
always @(*) begin
    if (direction == 1'b0)
        result = data << shift;
    else
        result = data >> shift;
end
endmodule

// Testbench
module tb_barrel_shifter;
reg [3:0] data;
reg [1:0] shift;


reg direction;
wire [3:0] result;

barrel_shifter uut (
    .data(data),
    .shift(shift),
    .direction(direction),
    .result(result)
);
initial begin

    $dumpfile("dump.vcd");
    $dumpvars;
    data = 4'b1011;
    direction = 0; shift = 0; #10;
    direction = 0; shift = 1; #10;
    direction = 0; shift = 2; #10;
    direction = 1; shift = 1; #10;
    direction = 1; shift = 2; #10;
    $finish;
end
initial begin
    $monitor("Time=%0t Data=%b Direction=%b Shift=%d Result=%b",
             $time, data, direction, shift, result);
end
endmodule