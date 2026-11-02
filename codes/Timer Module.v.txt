// Design: Timer Module
module timer_module(
    input clk,
    input reset,
    output reg timer_done
);
reg [3:0] count;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        timer_done <= 0;
    end
    else begin
        if (count == 4'd9) begin
            count <= 0;
            timer_done <= 1;
        end
        else begin
            count <= count + 1'b1;
            timer_done <= 0;
        end
    end
end
endmodule

// Testbench
module tb_timer_module;
reg clk, reset;
wire timer_done;
timer_module uut (
    .clk(clk),

    .reset(reset),
    .timer_done(timer_done)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    clk = 0;
    reset = 1;
    #12 reset = 0;
    #150;
    $finish;
end
initial begin
    $monitor("Time=%0t Reset=%b TimerDone=%b",
             $time, reset, timer_done);
end
endmodule
