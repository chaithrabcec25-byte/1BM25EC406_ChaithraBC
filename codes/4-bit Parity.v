// Design: 4-bit Parity Generator and Checker
module parity_generator_checker(
    input [3:0] data,
    input parity_in,
    output parity_bit,
    output error
);
assign parity_bit = ^data;
assign error = (^data) ^ parity_in;
endmodule

// Testbench
module tb_parity_generator_checker;
reg [3:0] data;
reg parity_in;
wire parity_bit, error;

parity_generator_checker uut (
    .data(data),
    .parity_in(parity_in),
    .parity_bit(parity_bit),

    .error(error)
);
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    data = 4'b1010;
    parity_in = 1'b0;
    #10;
    data = 4'b1100;
    parity_in = 1'b0;
    #10;
    data = 4'b1011;
    parity_in = 1'b1;
    #10;
    data = 4'b1011;
    parity_in = 1'b0;
    #10;
    $finish;
end
initial begin
    $monitor("Time=%0t Data=%b ParityBit=%b ParityIn=%b Error=%b",
             $time, data, parity_bit, parity_in, error);
end
endmodule