`timescale 1ns / 1ps

module TopLevelModule (
    input wire clk,
    input wire reset,
    input wire entry,
    input wire exit,
    input wire [1:0] Car_Id,
    output wire [8:0] Ccost,
    output wire [1:0] cars_count,
    output wire Is_empty,
    output wire Is_full,
    output wire [7:0] current_time 
);

    wire [7:0] Entry_time;
    wire write_enable, read_enable, count_up, count_down;
    wire clk_out;

    clock_divider clk_div (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_out)
    );

    timer time_gen (
        .clk(clk_out),
        .reset(reset),
        .current_time(current_time)
    );

    fsm state_machine (
        .clk(clk),
        .reset(reset),
        .entry(entry),
        .exit(exit),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .count_up(count_up),
        .count_down(count_down)
    );

    counter car_counter (
        .clk(clk),
        .reset(reset),
        .count_up(count_up),
        .count_down(count_down),
        .cars_count(cars_count),
        .Is_empty(Is_empty),
        .Is_full(Is_full)
    );

    parking_buffer buffer (
        .clk(clk),
        .reset(reset),
        .read_enable(read_enable),
        .write_enable(write_enable),
        .Car_Id(Car_Id),
        .current_time(current_time),
        .Entry_time(Entry_time)
    );

    ccost cost_calc (
        .clk(clk),
        .reset(reset),
        .current_time(current_time),
        .Entry_time(Entry_time),
        .Ccost(Ccost)
    );

endmodule