// Moore Sequence Detector for 101
module moore_fsm(
    input clk,
    input reset,
    input in,
    output reg out
);
reg [1:0] state;
parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= S0;
    else begin
        case (state)
            S0: state <= in ? S1 : S0;
            S1: state <= in ? S1 : S2;
            S2: state <= in ? S3 : S0;
            S3: state <= in ? S1 : S2;
            default: state <= S0;
        endcase
    end
end
always @(*) begin
    case (state)
        S3: out = 1'b1;
        default: out = 1'b0;
    endcase
end
endmodule

// Testbench
module tb_moore_fsm;
reg clk, reset, in;
wire out;
moore_fsm uut (
    .clk(clk),
    .reset(reset),
    .in(in),
    .out(out)
);

always #5 clk = ~clk;
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    clk = 0;
    reset = 1;
    in = 0;
    #10 reset = 0;
    in = 1; #10;
    in = 0; #10;
    in = 1; #10;
    in = 0; #10;
    in = 1; #10;
    #20;
    $finish;
end
initial begin
    $monitor("Time=%0t in=%b out=%b",
             $time, in, out);
end
endmodule