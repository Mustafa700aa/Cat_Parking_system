`timescale 1ns / 1ps
module parking_buffer (
    input wire clk,
    input wire reset,
    input wire read_enable,
    input wire write_enable,
    input wire [1:0] Car_Id,
    input wire [7:0] current_time,
    output reg [7:0] Entry_time
);

reg [7:0] storage_Time [0:2];

always @(posedge clk or posedge reset) begin
    if (reset) begin
        storage_Time[0] <= 0;
        storage_Time[1] <= 0;
        storage_Time[2] <= 0;
    end else if (write_enable && (Car_Id <= 2'b10)) begin
        storage_Time[Car_Id] <= current_time;
    end
end

always @(*) begin
    if (read_enable && (Car_Id <= 2'b10)) begin
        Entry_time = storage_Time[Car_Id];
    end else begin
        Entry_time = 0;
    end
end
endmodule