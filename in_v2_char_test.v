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
    wire wea = 0;
    wire [19:0] out;
    reg [11:0] addra;

    blk_mem_gen_0 a1(.clka(CLK),.wea(wea),.addra(addra),.douta(out));

    IN_V2_Char N1(CLK,KEY,out,v1new,u1new,spike);

    initial begin 
        KEY = 0; CLK = 0;addra=0;
        #10 KEY = 1;
        #10 KEY = 0; 
    end

    always#(1)begin
        CLK = ~CLK;
    end
    always@(posedge CLK)begin
        assign addra = addra + 12'b1;
    end


endmodule


