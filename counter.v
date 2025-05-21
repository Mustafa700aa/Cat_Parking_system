`timescale 1ns / 1ps
module counter (
    input wire clk,
    input wire reset,
    input wire count_up,
    input wire count_down,
    output reg [1:0] cars_count,
    output wire Is_empty,
    output wire Is_full
);

localparam MAX_CARS = 2'b11;
localparam MIN_CARS = 2'b00;

assign Is_empty = (cars_count == MIN_CARS);
assign Is_full = (cars_count == MAX_CARS);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cars_count <= MIN_CARS;
    end else begin
        if (count_up && !Is_full) begin
            cars_count <= cars_count + 1;
        end else if (count_down && !Is_empty) begin
            cars_count <= cars_count - 1;
        end
    end
end
endmodule