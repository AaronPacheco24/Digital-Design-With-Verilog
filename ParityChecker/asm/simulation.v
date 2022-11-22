`timescale 1ns / 1ps



module simulation();
parityasm uut(clock, load, dataA,serialout, parity,registerA);
reg clock, load;
reg [7:0] dataA;
wire [7:0]registerA;
wire serialout,parity;
initial begin
clock =0;
#1 clock =1;
#1 clock = 0;  dataA = 8'b11101010; load = 1;
#1 clock = 1; //start shifting. edge 1
#1 clock = 0; load =0;
#1 clock = 1;
#1 clock = 0;
#1 clock = 1;
#1 clock = 0;
#1 clock = 1;
#1 clock = 0;
#1 clock = 1;
#1 clock = 0;
#1 clock = 1;
#1 clock = 0;
#1 clock = 1;
#1 clock = 0;
#1 clock = 1;
#1 clock = 0;
#1 clock = 1;
#1 clock = 0;
#1 clock = 1;
#1 clock = 0;
end
endmodule
