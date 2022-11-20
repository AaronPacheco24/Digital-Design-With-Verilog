`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Lab8(input clock, output [7:0]AN, output [6:0]C);
wire outsig400hz;
wire outsig1hz;
wire [5:0]seconds,minutes;
wire [3:0]minutelow,minuteshigh,secondslow,secondshigh;
wire [1:0]muxselect;
wire [6:0]mx1,mx2,mx3,mx4;
wire [7:0]an1,an2,an3,an4;
fourhundredhzgen stage0(clock, outsig400hz);
onehzgen stage1(clock, outsig1hz);
twobitcntr stage2(outsig400hz,muxselect);
secondmincnt stage3(outsig1hz,seconds,minutes);
seconddcdr stage4(seconds,outsig1hz,an1,an2,mx1,mx2);
minutesdcdr stage5(minutes,outsig1hz,an3,an4,mx3,mx4);
mux stage6(mx1,mx2,mx3,mx4,an1,an2,an3,an4,muxselect,AN,C);
endmodule

module fourhundredhzgen(clk, sig);
input clk;
output reg sig;
reg [26:0]counter;
always @ (posedge clk)
begin 
counter = counter+1;
if (counter == 125_000)
    begin
    sig=~sig;
    counter =0;
    end
end
endmodule
 
module onehzgen(clck, signal);
input clck;
output reg signal;
reg [26:0]counter2;
always @ (posedge clck)
begin 
counter2 = counter2+1;
if (counter2 == 50_000_000)
    begin
    signal=~signal;
    counter2 =0;
    end
end
endmodule

module twobitcntr(insig,muxsel);
input insig; //input signal and clock
output reg [1:0]muxsel; //output is 2 bits wide, it is the select to be used for the multiplexer.
always @ (posedge insig) //at every positive edge, increment (non-blocking) S.
muxsel<=muxsel+1;  //add one. Non-blocking.
endmodule

module secondmincnt(insignal,secs,mins);
input insignal;
output reg [5:0]secs,mins;
always @(posedge insignal)
begin
secs = secs+1;
if ( secs > 59)
    begin 
    secs =0;
    mins = mins+1;
    end
    if(mins >60)
        begin
        mins = 0;
        end
end
endmodule

module seconddcdr(seconds,insig, ani,anii, muxin1,muxin2);
input [5:0]seconds;
input insig;
output reg [6:0] muxin1,muxin2;
output reg [7:0] ani,anii;
reg [3:0] upr;
reg [3:0] lower;
always @ (upr,lower)
begin
upr = seconds/10;
lower = seconds%10;
case (upr)
    0: begin muxin2 = 7'b1000000;anii=8'b11111101; end //0
    1: begin muxin2 = 7'b1111001;anii=8'b11111101; end //1
    2: begin muxin2 = 7'b0100100; anii=8'b11111101; end //2
    3: begin muxin2 = 7'b0110000; anii=8'b11111101; end //3
    4: begin muxin2 = 7'b0011001; anii=8'b11111101; end //4
    5: begin muxin2 = 7'b0010010; anii=8'b11111101; end //5
    6: begin muxin2 = 7'b0000010; anii=8'b11111101; end // number 6 on the 7-segment display.
    default:begin muxin2 = 7'b1111111; anii=8'b11111101;end
endcase
case (lower)
    0: begin muxin1 = 7'b1000000; ani=8'b11111110; end //0
    1: begin muxin1 = 7'b1111001; ani=8'b11111110; end //1
    2: begin muxin1 = 7'b0100100; ani=8'b11111110; end //2
    3: begin muxin1 = 7'b0110000; ani=8'b11111110; end //3,
    4: begin muxin1 = 7'b0011001; ani=8'b11111110; end //4
    5: begin muxin1 = 7'b0010010; ani=8'b11111110; end //5
    6: begin muxin1 = 7'b0000010; ani=8'b11111110; end // number 6 on the 7-segment display.
    7: begin muxin1 = 7'b1111000; ani=8'b11111110; end //7
    8: begin muxin1 = 7'b0000000; ani=8'b11111110; end //8
    9: begin muxin1 = 7'b0011000; ani=8'b11111110; end //9
    default: begin muxin1 = 7'b1111111; ani=8'b11111110; end
endcase
end
endmodule 

module minutesdcdr(mins,insig,aniii,aniv, muxin3,muxin4);
input [5:0]mins;
input insig;
output reg [6:0] muxin3,muxin4;
output reg [7:0] aniii,aniv;
reg [3:0] upr;
reg [3:0] lower;
always @ (upr, lower)
begin
upr = mins/10;
lower = mins%10;
case (upr)
    0: begin muxin4 = 7'b1000000; aniv=8'b11110111; end //0
    1: begin muxin4 = 7'b1111001; aniv=8'b11110111; end //1
    2: begin muxin4 = 7'b0100100; aniv=8'b11110111; end //2
    3: begin muxin4 = 7'b0110000; aniv=8'b11110111; end //3
    4: begin muxin4 = 7'b0011001; aniv=8'b11110111; end //4
    5: begin muxin4 = 7'b0010010; aniv=8'b11110111; end //5
    6: begin muxin4 = 7'b0000010; aniv=8'b11110111; end // number 6 on the 7-segment display.
    default: begin muxin4 = 7'b1111111; aniv=8'b11110111; end
endcase

case (lower)
    0: begin muxin3 = 7'b1000000; aniii=8'b11111011; end //0
    1: begin muxin3 = 7'b1111001; aniii=8'b11111011; end //1
    2: begin muxin3 = 7'b0100100; aniii=8'b11111011; end //2
    3: begin muxin3 = 7'b0110000; aniii=8'b11111011; end //3
    4: begin muxin3 = 7'b0011001; aniii=8'b11111011; end //4
    5: begin muxin3 = 7'b0010010; aniii=8'b11111011; end //5
    6: begin muxin3 = 7'b0000010; aniii=8'b11111011; end // number 6 on the 7-segment display.
    7: begin muxin3 = 7'b1111000; aniii=8'b11111011; end //7
    8: begin muxin3 = 7'b0000000; aniii=8'b11111011; end //8
    9: begin muxin3 = 7'b0011000; aniii=8'b11111011; end //9
    default: begin muxin3= 7'b1111111; aniii=8'b11111011;end
endcase
end
endmodule 


module mux(mx1,mx2,mx3,mx4,an1,an2,an3,an4,mxsl,an,c); //take in mux wires,an wires and muxsel wires and produce final c and an
input [6:0]mx1,mx2,mx3,mx4; //assign mx1-mx4 as inputs
input [7:0]an1,an2,an3,an4;
input [1:0]mxsl; //muxselect is an input
output reg [7:0]an; //an is one of 2 outputs
output reg [6:0]c; //c is a final output
always @ (mxsl) 
begin
case (mxsl)//if muxselect == 0,1,2,3 assign to the right mux line. this cycles through the 7-segments quickly
    0: 
    begin
    an = an1;//an1 turns on far right display
    c = mx1;//dispaly mx1 value
    end
    1:
    begin 
    an = an2; //turns on second from right display
    c = mx2; //display mx2 value on an2
    end
    2:
    begin
    an=an3; //turns on second from left display
    c=mx3; //display mx3 value on an3
    end
    3:
    begin 
    an =an4;//turns on far left display
    c=mx4; //display mx4 value on an4
    end
    endcase
end
endmodule
