`timescale 1ns / 1ps
module timer (
    input clk,     
    input reset,
    output reg [7:0] current_time
);
always @(posedge clk or posedge reset) begin
    if (reset)
        current_time <= 0;
    else
        current_time <= current_time + 1; 
end
endmodule