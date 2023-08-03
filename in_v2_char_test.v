`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.06.2023 21:37:06
// Design Name: 
// Module Name: ecg_encoder
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


module ecg_encoder();

    reg signed [19:0]I_ecg, I_ecg_neg ;
    wire signed [19:0]Vn1,Un1, Vn2, Un2;
    wire spike,spike1 ,spike2;
    reg clk, reset;
    reg [11:0]  k;

    reg [19:0] ecg[3596:0];

    initial begin
        $readmemh("C:/Users/KRISHNA/Desktop/study material/ECG/samples/mit107.txt", ecg);
    end

    IN_V2_Char uut1(clk,reset,I_ecg,Vn1,Un1,spike1);
    IN_V2_Char uut2(clk,reset,I_ecg_neg,Vn2,Un2,spike2);

    assign spike = spike1+spike2;

    initial begin
        clk=0;reset =0 ;I_ecg =20'sh0_0000 ;I_ecg_neg =20'sh0_FFFF;k=0;
        #10 reset = 1;
        #10 reset = 0;    
    end

    always #(1) begin                          
        clk = ~clk;
        k = k + 12'b1;
        I_ecg = ecg[k];
        I_ecg_neg = (20'shF_FFFF - I_ecg);
        if (k == 12'he06) begin
            $finish();
        end 
    end



endmodule

