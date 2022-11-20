`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Aaron Pacheco 
module simulation();
shift4 uut(R,L,w,Clock,Q);
reg [3:0]R;
reg L;reg w; reg Clock;
wire [3:0]Q;
initial begin
L =0;w=0;R=4'b0000;Clock=0;

#1 L=1; R = 4'b1001; L =1; //Load is on. Loading R = 1001 into Q. Now Allow  it to go for 4 cycles.
#1 Clock = 1; //First Positive edge
#1 
#1 Clock = 0; //First falling edge
#1 R = 4'b0011; //Q Should be loaded with Rs value
#1 Clock = 1;//second Rising edge 1 CLOCK CYCLE FROM Q ON AND L ON
#1  
#1 Clock = 0; ///second falling edge 
#1 R=4'b0110; //Q Should be loaded with 4'b0110
#1 Clock = 1; //Third rising 2 CLOCK CYCLE FROM Q ON AND L ON
#1
#1 Clock =0; //Third falling 
#1 R=4'b1110; //Q Should be loaded with 4'b1110
#1 Clock =1; //Fourth rising 3 CLOCK CYCLE FROM Q ON AND L ON
#1
#1 Clock =0; //#Fourth Falling. 
#1 R=4'b1010; //Q Should be loaded with 4'b1010
#1 Clock =1; // 4 CLock cycle from Q on and L on
#1
#1 Clock =0; //s
#1 //Just befor clock rises again. Set Load to 0. Shift is on. We will be shifting Q over 4 clocks.
#1 Clock =1; //Load is now off.. starting 4 clock cycle Q = 4'b1010
#1 L =0; 
#1 Clock =0;
#1 
#1 Clock =1; //first clock cycle done with load off. Q should = 4'b0101
#1
#1 Clock =0; 
#1 
#1 Clock =1; //Second clock cycle complete with load off Q should = 4'b0010
#1 
#1 Clock =0;
#1 
#1 Clock =1;//Third Clock cycle complete with Load off. Q should = 4'b0001
#1 
#1 Clock =0; 
#1 
#1 Clock =1;//Fourth Clock cycle with load off. At this point, Q should = 4'b0000
#1 
#1 Clock =0; 
end
endmodule
