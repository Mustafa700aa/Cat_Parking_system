`timescale 1ns / 1ps

module fsm (
    input wire clk,
    input wire reset,
    input wire entry,
    input wire exit,
    input wire is_empty,
    input wire is_full,
    output reg write_enable,
    output reg read_enable
);

    // تعريف الحالات
    localparam IDLE = 2'b00,
               ENTRY = 2'b01,
               EXIT = 2'b10;
    reg [1:0] current_state, next_state;

    // متغيرات لتخزين القيم السابقة واكتشاف النبضات
    reg entry_prev, exit_prev;
    wire entry_pulse, exit_pulse;

    // اكتشاف النبضات
    assign entry_pulse = entry && !entry_prev;
    assign exit_pulse = exit && !exit_prev;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            entry_prev <= 0;
            exit_prev <= 0;
            current_state <= IDLE;
        end else begin
            entry_prev <= entry;
            exit_prev <= exit;
            current_state <= next_state;
        end
    end

    // منطق الانتقال بين الحالات
    always @(*) begin
        next_state = current_state;
        write_enable = 0;
        read_enable = 0;
        case (current_state)
            IDLE: begin
                if (entry_pulse && !is_full) begin
                    next_state = ENTRY;
                end else if (exit_pulse && !is_empty) begin
                    next_state = EXIT;
                end
            end
            ENTRY: begin
                write_enable = 1;
                next_state = IDLE;
            end
            EXIT: begin
                read_enable = 1;
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule