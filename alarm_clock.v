//This is module code

`timescale 1ns / 1ps


module alarmclock(input clk,alarmsw,input [3:0]seclow,input [2:0]sechi,input [3:0]minlow,input [2:0]minhi,output [7:0]AN, output [6:0]c,output audioOut,output aud_sd,output alarmen); //1 switch for enable alarm. 3 switches each for minutes/seconds higher and lower
wire outsig400hz;
wire outsig1hz;
wire [5:0]seconds,minutes;
wire [2:0]muxselect;
wire [6:0] mx1,mx2,mx3,mx4,mx5,mx6,mx7,mx8;
wire [7:0] an1,an2,an3,an4,an5,an6,an7,an8;
wire z;
fourhundredhzgen stage0(clk,outsig400hz);
onehzgen stage1(clk,outsig1hz);
threebitcntr stage2(outsig400hz,muxselect);
secondmincnt stage3(outsig1hz,seconds,minutes);
seconddcdr stage4(seconds,outsig1hz,an1,an2,mx1,mx2);
minutesdcdr stage5(minutes,outsig1hz,an3,an4,mx3,mx4);
alarmset stage6(seclow,sechi,minlow,minhi,mx5,mx6,mx7,mx8,an5,an6,an7,an8);
eightto1mux stage7(mx1,mx2,mx3,mx4,mx5,mx6,mx7,mx8,an1,an2,an3,an4,an5,an6,an7,an8,muxselect,alarmsw,c,AN,alarmen,z);
SongPlayer stage8(clk,z,alarmsw,audioOut,aud_sd);
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

module threebitcntr(insig,muxsel);
input insig; //input signal and clock
output reg [2:0]muxsel; //output is 2 bits wide, it is the select to be used for the multiplexer.
always @ (posedge insig) //at every positive edge, increment (non-blocking) S.
muxsel<=muxsel+1;  //add one. Non-blocking.
endmodule

module alarmset(sclw,schi,mnlw,mnhi,muxin5,muxin6,muxin7,muxin8,anv,anvi,anvii,anviii);
input [2:0]mnhi,schi;
input [3:0]mnlw,sclw;
output reg [6:0] muxin5,muxin6,muxin7,muxin8;
output reg [7:0]anv,anvi,anvii,anviii;
always @ *
begin
case(sclw) //lower seconds case for input
    0: begin muxin5 = 7'b1000000;anv = 8'b11101111;end //input 0. the mux will show 0.
    1: begin muxin5 = 7'b1111001;anv = 8'b11101111;end //input 1 shows on 5 7seg...
    2: begin muxin5 = 7'b0100100;anv = 8'b11101111;end
    3: begin muxin5 = 7'b0110000;anv = 8'b11101111;end
    4: begin muxin5 = 7'b0011001;anv = 8'b11101111;end
    5: begin muxin5 = 7'b0010010;anv = 8'b11101111;end
    6: begin muxin5 = 7'b0000010;anv = 8'b11101111;end
    7: begin muxin5 = 7'b1111000;anv = 8'b11101111;end
    8: begin muxin5 = 7'b0000000;anv = 8'b11101111;end
    9: begin muxin5 = 7'b0011000;anv = 8'b11101111;end
    default: begin muxin5 =7'b1000000;anv = 8'b11101111; end
endcase
case(schi) //upper seconds case for input
    0: begin muxin6 = 7'b1000000;anvi = 8'b11011111;end //input 0. the mux will show 0.
    1: begin muxin6 = 7'b1111001;anvi = 8'b11011111;end //input 1 shows on 5 7seg...
    2: begin muxin6 = 7'b0100100;anvi = 8'b11011111;end
    3: begin muxin6 = 7'b0110000;anvi = 8'b11011111;end
    4: begin muxin6 = 7'b0011001;anvi = 8'b11011111;end
    5: begin muxin6 = 7'b0010010;anvi = 8'b11011111;end
    default: begin muxin6 =7'b1000000;anvi = 8'b11011111; end
endcase
case(mnlw) //lower minutes case for input
    0: begin muxin7 = 7'b1000000;anvii = 8'b10111111;end //input 0. the mux will show 0.
    1: begin muxin7 = 7'b1111001;anvii = 8'b10111111;end //input 1 shows on 5 7seg...
    2: begin muxin7 = 7'b0100100;anvii = 8'b10111111;end
    3: begin muxin7 = 7'b0110000;anvii = 8'b10111111;end
    4: begin muxin7 = 7'b0011001;anvii = 8'b10111111;end
    5: begin muxin7 = 7'b0010010;anvii = 8'b10111111;end
    6: begin muxin7 = 7'b0000010;anvii = 8'b10111111;end
    7: begin muxin7 = 7'b1111000;anvii = 8'b10111111;end
    8: begin muxin7 = 7'b0000000;anvii = 8'b10111111;end
    9: begin muxin7 = 7'b0011000;anvii = 8'b10111111;end
    default: begin muxin7 =7'b1000000;anvii = 8'b10111111; end
endcase
case(mnhi) //uppper minutes case for input
    0: begin muxin8 = 7'b1000000;anviii = 8'b01111111;end //input 0. the mux will show 0.
    1: begin muxin8 = 7'b1111001;anviii = 8'b01111111;end //input 1 shows on 5 7seg...
    2: begin muxin8 = 7'b0100100;anviii = 8'b01111111;end
    3: begin muxin8 = 7'b0110000;anviii = 8'b01111111;end
    4: begin muxin8 = 7'b0011001;anviii = 8'b01111111;end
    5: begin muxin8 = 7'b0010010;anviii = 8'b01111111;end //minutes can only go up to 59. so alarm stops at 5 upper min
    default: begin muxin8 =7'b1000000;anviii = 8'b01111111; end//if over 5 we go back to 0.
endcase
end
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



module eightto1mux(mux1,mux2,mux3,mux4,mux5,mux6,mux7,mux8,An1,An2,An3,An4,An5,An6,An7,An8,mxsel,alarm,C,an,alarmled,Z);
input [6:0]mux1,mux2,mux3,mux4,mux5,mux6,mux7,mux8;
input [7:0]An1,An2,An3,An4,An5,An6,An7,An8;
input [2:0]mxsel;
input alarm;
output reg Z;
output reg[6:0]C;
output reg[7:0]an;
output reg alarmled;
always @(mxsel)
begin
alarmled = alarm;
case (mxsel)
    0: begin an = An1; C= mux1; end
    1: begin an = An2; C= mux2; end
    2: begin an = An3; C= mux3; end
    3: begin an = An4; C= mux4; end
    4: begin an = An5; C= mux5; end
    5: begin an = An6; C= mux6; end
    6: begin an = An7; C= mux7; end
    7: begin an = An8; C= mux8; end
endcase
if (alarm ==1)
begin
    if (Z==0)
    begin
    if (mux4==mux8 && mux3==mux7 && mux2==mux6 && mux1==mux5)
        Z=1;
    end
end
if (alarm ==0)Z=0;
end
endmodule

module MusicSheet( input [9:0] number, output reg [19:0] note, output reg [4:0] duration);
parameter   QUARTER = 5'b00010;//2
parameter HALF = 5'b00100;
parameter ONE = 2* HALF;
parameter TWO = 2* ONE;
parameter FOUR = 2* TWO;
parameter EIGHTH = HALF/2;
parameter SIXTEENTH = EIGHTH /2;
parameter A3=227272,A3S=214518,B3=202478,C3=191113,D3S=180384,D3=170262,E3B=160707,E3=151687,F3=143172,F3S=135137,G3=127552,G3S=120393,A4 = 113636, A4S= 107259,B4=101239,C4=95556, D4S=90192, D4=85131, E4B = 80353, E4 = 75843, F4=71586,F4S = 67568, G4 = 63776,G4S=60196,A5=56818,A5S=53629,B5=50619,C5=47778,D5S=45096,D5=42565,E5B=40176,E5=37921,F5=35793,F5S=33784,G5=31888,G5S=30098,A6=28409,SP = 1;  
always @ (number) begin
case(number) //Row Row Row your boat
0: begin note = C5; duration = EIGHTH; end //START FIRST MEASURE
1: begin note = SP; duration = SIXTEENTH; end 
2: begin note = C5; duration = EIGHTH; end //
3: begin note = SP; duration = SIXTEENTH; end 
4: begin note = C5; duration = EIGHTH; end //row
5: begin note = SP; duration = SIXTEENTH; end
6: begin note = G5; duration = SIXTEENTH; end //
7: begin note = E5; duration = SIXTEENTH; end //row
8: begin note = G5; duration = EIGHTH; end //
9: begin note = E5; duration = SIXTEENTH; end //your
10: begin note = D5; duration = SIXTEENTH; end //END FIRST MEASURE
11: begin note = SP; duration =  SIXTEENTH; end
12: begin note = C5; duration =  EIGHTH; end //START SECOND MEASURE
13: begin note = SP; duration =  SIXTEENTH; end
14: begin note = C5; duration =  EIGHTH; end //
15: begin note = SP; duration =  SIXTEENTH; end
16: begin note = C5; duration =  EIGHTH; end //
17: begin note = SP; duration =  SIXTEENTH; end
18: begin note = G5; duration = SIXTEENTH; end //
19: begin note = E5; duration = SIXTEENTH; end //
20: begin note = G5; duration = EIGHTH; end //
21: begin note = E5; duration = SIXTEENTH; end //
22: begin note = D5; duration = SIXTEENTH; end //END SECONDMEASURE
23: begin note = SP; duration = SIXTEENTH; end
24: begin note = C5; duration = EIGHTH; end //START THIRD MEASURE
25: begin note = SP; duration = SIXTEENTH; end
26: begin note = C5; duration = EIGHTH; end //
27: begin note = SP; duration = SIXTEENTH; end
28: begin note = C5; duration = EIGHTH; end //
29: begin note = SP; duration = SIXTEENTH; end
30: begin note = G5; duration = SIXTEENTH; end //
31: begin note = E5; duration = SIXTEENTH; end //
32: begin note = G5; duration = EIGHTH; end //
33: begin note = E5; duration = SIXTEENTH; end //
34: begin note = D5; duration = SIXTEENTH; end //END THIRD MEASURE
35: begin note = SP; duration = SIXTEENTH; end
36: begin note = C5; duration = EIGHTH; end //START FOURTH MEASURE
37: begin note = SP; duration = SIXTEENTH; end
38: begin note = C5; duration = SIXTEENTH; end //
39: begin note = SP; duration = SIXTEENTH; end
40: begin note = C5; duration = SIXTEENTH; end //
41: begin note = SP; duration = SIXTEENTH; end
42: begin note = G5; duration = SIXTEENTH; end 
43: begin note = A6; duration = SIXTEENTH; end //
44: begin note = E5; duration = EIGHTH; end //
45: begin note = SP; duration = SIXTEENTH; end
46: begin note = E5; duration = SIXTEENTH; end //
47: begin note = D5; duration = SIXTEENTH; end //END FOURTH MEASURE
48: begin note = SP; duration = SIXTEENTH; end
default: begin note = C4; duration = FOUR; end
endcase
end
endmodule

module SongPlayer(clck,Z,alarmswitch,audout,audsd);
input clck;
//input [6:0]mv1,mv2,mv3,mv4,mv5,mv6,mv7,mv8; //MV =MuxVal.
input alarmswitch;
input Z;
output reg audout;
output wire audsd;
reg [19:0] counter;
reg [31:0] time1, noteTime;
reg [9:0] msec, number; //millisecond counter, and sequence number of musical note.
wire [4:0] note, duration;
wire [19:0] notePeriod;
parameter clockFrequency = 100_000_000; 
assign aud_sd = 1'b1;
MusicSheet  mysong(number, notePeriod, duration );
always @ (posedge clck) 
  begin
if(alarmswitch == 0) 
 begin 
          counter <=0;  
          time1<=0;  
          number <=0;  
          audout <=1;
      end
else 
begin
if(Z>=1)
begin
counter <= counter + 1; 
time1<= time1+1;
if( counter >= notePeriod) 
   begin
counter <=0;  
audout <= ~audout; 
   end //toggle audio output 
if( time1 >= noteTime) 
begin
time1 <=0;  
number <= number + 1; 
end  //play next note
 if(number == 64) number <=0; // Make the number reset at the end of the song
end
end
  end
         
  always @(duration) noteTime = (duration * clockFrequency/8); 
       //number of   FPGA clock periods in one note.
endmodule 
