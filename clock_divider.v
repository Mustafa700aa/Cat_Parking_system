`timescale 1ns / 1ps

module clock_divider (
    input clk,     
    input reset,        
    output reg clk_out  
);
    reg [22:0] counter;  

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end
        else if (counter == 6_249_999) begin 
            counter <= 0;
            clk_out <= ~clk_out;
        end
        else begin
            counter <= counter + 1;
        end
    end
endmodule