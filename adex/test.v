`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2022 16:51:12
// Design Name: 
// Module Name: test
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


module test();

    reg clk,rst;
    wire V_B,V;
    reg [22:0]I_B,I;

    // 7,16,3,3,9,10,23'sh0_0780_3,23'shF_EDED_3,38'sh0_0000_0002_B normal
    AdEx #(7,16,20,13,9,14,23'sh0_7828_4,23'shF_EE14_8,38'sh0_0000_0003_A)N(clk,rst,I,V);
    //AdEx #(7,16,9,10,9,10,23'sh0_0780_3,23'shF_F439_5,38'sh0_0009_0002_B)B(clk,rst,I_B,V_B);


    initial begin 
        clk = 0;rst = 1;I_B=0;I=0;
        #10 rst = 0;
        #10 rst = 1;
        //#20 I_B = 23'sh0_0000_8; I = 23'sh0_000A_0;
    end

    always#(1) clk = ~clk;
    always#(2000) I = I + 1;

endmodule
