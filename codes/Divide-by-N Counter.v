//  Divide-by-N Counter
module divide_by_n #(parameter N = 4)(
    input clk,
    input reset,
    output reg clk_out
);
integer count;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        clk_out <= 0;
    end
    else begin
        if (count == (N/2)-1) begin
            count <= 0;
            clk_out <= ~clk_out;
        end
        else begin
            count <= count + 1;
        end
    end
end
endmodule

// Testbench
module tb_divide_by_n;
reg clk, reset;
wire clk_out;
divide_by_n #(4) uut (
    .clk(clk),
    .reset(reset),
    .clk_out(clk_out)
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
    $monitor("Time=%0t Reset=%b Clock_Out=%b",
             $time, reset, clk_out);
end
endmodule