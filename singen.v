module sine_gen(clk, reset, en, sine);
   input clk, reset, en;
   output [19:0] sine;
   reg [19:0] sine_r, cos_r;
   wire [19:0] cos;
   assign      sine = sine_r + {cos_r[19], cos_r[19], cos_r[19], cos_r[19], cos_r[19], cos_r[19], cos_r[19], cos_r[19], cos_r[19:8]};//{cos_r[19], cos_r[19], cos_r[19], cos_r[19:3]};
   assign      cos  = cos_r - {sine[19], sine[19], sine[19], sine[19], sine[19], sine[19], sine[19], sine[19], sine[19:8]};//{sine[19], sine[19], sine[19], sine[19:3]};
   always@(posedge clk or negedge reset)
     begin
         if (!reset) begin
             sine_r <= 20'sh0_0000;
             cos_r <= 20'sh0_2666;
         end else begin
             if (en) begin
                 sine_r <= sine;
                 cos_r <= cos;
             end
         end
     end
endmodule