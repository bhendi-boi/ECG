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
    wire spike_neg,spike;
    reg [23:0] I_ecg_neg,I_ecg;
    wire signed [22:0] V_mem_neg,V_mem;

    reg [11:0]  k;

    reg [23:0] ecg[3602:0];

    initial begin
        $readmemb("C:/Users/KRISHNA/Desktop/study material/ECG/samples/mit203Adex.txt", ecg);
    end


    // 7,16,3,3,9,10,23'sh0_0780_3,23'shF_EDED_3,38'sh0_0000_0002_B normal
    AdEx #(7,16,20,13,9,14,23'sh0_7828_4,23'shF_EE14_8,38'sh0_0000_0003_A)N(clk,rst,I_ecg,spike,V_mem);
    AdEx #(7,16,9,10,9,10,23'sh0_0780_3,23'shF_F439_5,38'sh0_0009_0002_B)B(clk,rst,I_ecg_neg,spike_neg,V_mem_neg);


    initial begin 
        clk = 0;rst = 1;I_ecg_neg=0;I_ecg=0;k=0;
        #10 rst = 0;
        #10 rst = 1;
        //#20 I_ecg_neg = 23'sh0_0000_8; I_ecg = 23'sh0_000A_0;
    end

    always #(1) begin                          
        clk = ~clk;
        k = k + 12'b1;
        I_ecg = ecg[k];
        I_ecg_neg = (24'sh8F_FFFF - I_ecg);
        if (k == 12'hE12) begin
            $finish();
        end 
    end

endmodule
