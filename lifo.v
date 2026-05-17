`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2026 10:05:27
// Design Name: 
// Module Name: lifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lifo (

    input wire clk,
    input wire rst,

    input wire push,
    input wire pop,

    input wire [7:0] din,

    output reg [7:0] dout

);

    // Stack Memory
    reg [7:0] stack [7:0];

    // Stack Pointer
    reg [2:0] sp;

    integer i;

    always @(posedge clk) begin

        // Reset
        if (rst) begin

            sp <= 0;
            dout <= 0;

            // Optional clear
            for(i=0; i<8; i=i+1)
                stack[i] <= 0;

        end

        else begin

            // PUSH Operation
            if (push) begin

                stack[sp] <= din;

                sp <= sp + 1;

            end

            // POP Operation
            else if (pop) begin

                sp <= sp - 1;

                dout <= stack[sp-1];

            end

        end
    end

endmodule
