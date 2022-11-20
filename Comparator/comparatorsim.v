`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//aaron pacheco

//N was chosen to be 4.
module comparatorsim(); 
reg [3:0]X;
reg [3:0] Y;
wire V,N,Z;
comparator uut(X, Y, V, N, Z);
initial begin
X = 4'b0100;Y = 4'b0100; //case 1. X=Y.
#1 X = 4'b0010; Y = 4'b0110; // case 2 -> X<Y.
#1 X = 4'b0100; Y = 4'b0001; //case 3 -> X>Y.
#1 X= 4'b1000; Y = 4'b0001; //case 4 -> overflow
end
endmodule
