`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2026 10:07:16
// Design Name: 
// Module Name: lifo_tb
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


module lifo_tb();


    reg clk;
    reg rst;

    reg push;
    reg pop;

    reg [7:0] din;

    wire [7:0] dout;

    // DUT
    lifo uut (

        .clk(clk),
        .rst(rst),

        .push(push),
        .pop(pop),

        .din(din),

        .dout(dout)

    );

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Initialize
    task initialize;
    begin
        rst  = 1;
        push = 0;
        pop  = 0;
        din  = 0;
    end
    endtask

    // Push Task
    task push_data(input [7:0] data);
    begin

        @(posedge clk);

        push = 1;
        din  = data;

        @(posedge clk);

        push = 0;

    end
    endtask

    // Pop Task
    task pop_data;
    begin

        @(posedge clk);

        pop = 1;

        @(posedge clk);

        pop = 0;

    end
    endtask

    // Stimulus
    initial begin

        initialize;

        #10 rst = 0;

        // PUSH
        push_data(8'hAA);
        push_data(8'hBB);
        push_data(8'hCC);

        // POP
        pop_data;
        pop_data;
        pop_data;

        #20;
        $finish;

    end

    // Monitor
    initial begin

        $monitor("TIME=%0t push=%b pop=%b din=%h dout=%h",
                  $time, push, pop, din, dout);

    end

endmodule