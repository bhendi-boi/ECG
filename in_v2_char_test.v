`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2023 14:16:38
// Design Name: 
// Module Name: in_v2_char_test
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


module in_v2_char_test();

    reg CLK,KEY;
    wire [19:0] v1new, u1new;
    wire spike;
    reg signed [19:0] ecg[999:0];
    reg signed[19:0] I_ecg;
    wire en = 1;
    wire wea = 0;
    wire [19:0] out,in;
    reg [10:0] addra = 11'sh003;

    reg [9:0] k;
    initial $readmemh("C:/Users/KRISHNA/Desktop/study material/ECG/samples/normal.txt",ecg);


    IN_V2_Char N1(CLK,KEY,I_ecg,v1new,u1new,spike);

    initial begin 
        KEY = 0; CLK = 0; I_ecg = 1'b0; k = 0;
        #10 KEY = 1;
        #10 KEY = 0; 
    end

    always#(1)begin
        CLK = ~CLK;
        I_ecg = ecg[k];
        k = k + 10'b1;
    end

endmodule


