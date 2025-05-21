`timescale 1ns / 1ps
module ccost (
    input wire clk,
    input wire reset,
    input wire [7:0] current_time,
    input wire [7:0] Entry_time,
    output reg [8:0] Ccost 
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Ccost <= 0;
    end else if (Entry_time != 0) begin
        if (current_time >= Entry_time) begin
            Ccost <= current_time - Entry_time;
        end else begin
            Ccost <= (255 - Entry_time) + current_time + 1;
        end
    end else begin
        Ccost <= 0;
    end
end
endmodule