//  Mealy Sequence Detector for 101
module mealy_fsm(
    input clk,
    input reset,
    input in,
    output reg out
);
reg [1:0] state;
parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
        out <= 1'b0;
    end
    else begin
        case (state)
            S0: begin
                out <= 1'b0;
                if (in)
                    state <= S1;
                else
                    state <= S0;
            end

            S1: begin
                out <= 1'b0;
                if (in)
                    state <= S1;

                else
                    state <= S2;
            end
            S2: begin
                if (in) begin
                    out <= 1'b1;
                    state <= S1;
                end
                else begin
                    out <= 1'b0;
                    state <= S0;
                end
            end
            default: begin
                state <= S0;
                out <= 1'b0;
            end
        endcase
    end
end
endmodule

// Testbench
module tb_mealy_fsm;
reg clk, reset, in;
wire out;
mealy_fsm uut (
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