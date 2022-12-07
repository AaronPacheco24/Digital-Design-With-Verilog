`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2022 07:34:27 PM
// Design Name: 
// Module Name: juke
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


module juke(input clock, input [1:0]userselect, output reg [6:0]C, output reg [7:0]AN,output reg aud_sd=1, output reg audio_Out);
reg [19:0] counter; 
reg [31:0] time1,noteTime;
reg [9:0]msec,number;
wire [4:0] note,duration;
wire [19:0] notePeriod;
parameter clockFrequency = 100_000_000;
reg [1:0] state_reg;
localparam [1:0] s1=2'b01,s2=2'b10,s3=2'b11;
reg [1:0]userin;
reg [1:0] state_next;
reg segclock; 
reg [26:0]counter1;
reg [7:0] an1=8'b11111110,an2=8'b11111101,an3=8'b11111011,an4=8'b11110111,an5=8'b11101111,an6=8'b11011111,an7=8'b10111111,an8=8'b01111111;
reg [6:0] c1,c2,c3,c4,c5,c6,c7,c8;
reg [2:0] displayselect;

MusicSheet  mysong(userin,number, notePeriod, duration );
always @ (posedge clock)
begin
counter1 = counter1 +1;
    if (counter1 == 125_000)
    begin 
        segclock = ~segclock;
        counter1 = 0;
    end
end

always @ (posedge segclock)
begin
displayselect<=displayselect+1;
state_reg<=state_next;
end

always @ (displayselect)
begin
case (userselect)
    0: begin c1 = 7'b1111111;c2=7'b1111111;c3=7'b1111111;c4=7'b1111111;c5=7'b1111111;c6=7'b1111111;c7=7'b1111111;c8=7'b1111111; end
    1: begin c1 = 7'b0101011;c2=7'b0001011;c3=7'b1000110;c4=7'b1011000;c5=7'b1001100;c6=7'b0100001;c7=7'b0001000;c8=7'b0010010; end
    2: begin c1 = 7'b0001100;c2=7'b0101111;c3=7'b1000001;c4=7'b0010010;c5=7'b0100011;c6=7'b0101011;c7=7'b00001011;c8=7'b0101111; end
    3: begin c1 = 7'b1111111;c2=7'b0010001;c3=7'b0100011;c4=7'b1100001;c5=7'b0100100;c6=7'b0000110;c7=7'b0100001;c8=7'b0100011; end
    default: begin c1 = 7'b1111111;c2=7'b1111111;c3=7'b1111111;c4=7'b1111111;c5=7'b1111111;c6=7'b1111111;c7=7'b1111111;c8=7'b1111111;end
endcase
case (displayselect)
    0: begin AN = an1; C = c1; end
    1: begin AN = an2; C = c2; end
    2: begin AN = an3; C = c3; end
    3: begin AN = an4; C = c4; end
    4: begin AN = an5; C = c5; end
    5: begin AN = an6; C = c6; end
    6: begin AN = an7; C = c7; end
    7: begin AN = an8; C = c8; end
endcase
end
always @ (duration) noteTime = (duration*clockFrequency/8); 
always @ (posedge clock)
begin
state_next = state_reg;
userin = userselect;
case(state_reg)
    s1:
    begin
        if (userselect==0)
        begin
            state_next =s1;
            counter = 0;
            time1 = 0;
            number =0;
            audio_Out =0;
            
        end
        else
        
            state_next = s2;
    end
    s2:
    begin
        if(userselect !=0)
        begin
            state_next = s2;
            counter = counter +1;
            time1 = time1+1;
            if (counter>=notePeriod)
            begin
                counter =0;
                audio_Out =~audio_Out;
            end
            if (time1>=noteTime)
            begin
                time1=0;
                number = number+1;
            end
            if (number == 58) 
            begin 
                number =0; 
            end
 

        end
        else
        begin
            state_next = s1;
        end
    end       
    default: 
    begin
        state_next = s1;
    end
endcase
end
endmodule



module MusicSheet( input [1:0] sc,input [9:0] number, output reg [19:0] note, output reg [4:0] duration);
parameter   QUARTER = 5'b00010;//2
parameter HALF = 5'b00100;
parameter ONE = 2* HALF;
parameter TWO = 2* ONE;
parameter FOUR = 2* TWO;
parameter EIGHTH = HALF/2;
parameter SIXTEENTH = EIGHTH /2;
parameter A3=227272,A3S=214518,B3=202478,C3=191113,D3S=180384,D3=170262,E3B=160707,E3=151687,F3=143172,F3S=135137,G3=127552,G3S=120393,A4 = 113636, A4S= 107259,B4=101239,C4=95556, D4S=90192, D4=85131, E4B = 80353, E4 = 75843, F4=71586,F4S = 67568, G4 = 63776,G4S=60196,A5=56818,A5S=53629,B5=50619,C5=47778,D5S=45096,D5=42565,E5B=40176,E5=37921,F5=35793,F5S=33784,G5=31888,G5S=30098,A6=28409,SP = 1;  
always @ (number) 
begin
case(sc)
    1: begin
    case(number) //This is SAD MACHINE
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
        49: begin note = SP; duration = SIXTEENTH; end
        50: begin note = SP; duration = SIXTEENTH; end
        51: begin note = SP; duration = SIXTEENTH; end
        52: begin note = SP; duration = SIXTEENTH; end
        53: begin note = SP; duration = SIXTEENTH; end
        54: begin note = SP; duration = SIXTEENTH; end
        55: begin note = SP; duration = SIXTEENTH; end
        56: begin note = SP; duration = SIXTEENTH; end
        57: begin note = SP; duration = SIXTEENTH; end
        58: begin note = SP; duration = SIXTEENTH; end
        default: begin note = C4; duration = FOUR; end
     endcase 
     end
    2:begin
    case(number) //THIS IS NO SURPRISES
        0: begin note = A5; duration = EIGHTH; end //START FIRST MEASURE
        1: begin note = SP; duration = SIXTEENTH; end 
        2: begin note = C4; duration = EIGHTH; end //
        3: begin note = SP; duration = SIXTEENTH; end 
        4: begin note = F5; duration = EIGHTH; end //
        5: begin note = SP; duration = SIXTEENTH; end
        6: begin note = C4; duration = EIGHTH; end //
        7: begin note = SP; duration = SIXTEENTH; end //
        8: begin note = A5; duration = EIGHTH; end //
        9: begin note = SP; duration = SIXTEENTH; end //
        10: begin note = C4; duration = EIGHTH; end //
        11: begin note = SP; duration =  SIXTEENTH; end
        12: begin note = F5; duration =  EIGHTH; end //
        13: begin note = SP; duration =  SIXTEENTH; end
        14: begin note = C4; duration =  EIGHTH; end //
        15: begin note = SP; duration =  SIXTEENTH; end //end first measure
        16: begin note = A5; duration =  EIGHTH; end // start second measure
        17: begin note = SP; duration =  SIXTEENTH; end
        18: begin note = C4; duration = EIGHTH; end //
        19: begin note = SP; duration = SIXTEENTH; end //
        20: begin note = F5; duration = EIGHTH; end //
        21: begin note = SP; duration = SIXTEENTH; end //
        22: begin note = C4; duration = EIGHTH; end //
        23: begin note = SP; duration = SIXTEENTH; end
        24: begin note = B4; duration = EIGHTH; end //
        25: begin note = SP; duration = SIXTEENTH; end
        26: begin note = D4; duration = EIGHTH; end //
        27: begin note = SP; duration = SIXTEENTH; end
        28: begin note = F5; duration = EIGHTH; end //
        29: begin note = SP; duration = SIXTEENTH; end
        30: begin note = G5; duration = EIGHTH; end // 
        31: begin note = SP; duration = SIXTEENTH; end // END SECONDMEASURE
        32: begin note = A4; duration = EIGHTH; end // start third measure
        33: begin note = SP; duration = SIXTEENTH; end //
        34: begin note = C3; duration = EIGHTH; end //END THIRD MEASURE
        35: begin note = SP; duration = SIXTEENTH; end
        36: begin note = F4; duration = EIGHTH; end //START FOURTH MEASURE
        37: begin note = SP; duration = SIXTEENTH; end
        38: begin note = C3; duration = EIGHTH; end //
        39: begin note = SP; duration = SIXTEENTH; end
        40: begin note = A4; duration = EIGHTH; end //
        41: begin note = SP; duration = SIXTEENTH; end
        42: begin note = C3; duration = EIGHTH; end 
        43: begin note = SP; duration = SIXTEENTH; end //END FOURTH MEASURE
        44: begin note = A4; duration = EIGHTH; end //START 5th MEASURE
        45: begin note = SP; duration = SIXTEENTH; end
        46: begin note = F4; duration = EIGHTH; end //
        47: begin note = SP; duration = SIXTEENTH; end // end third measure
        48: begin note = B3; duration = EIGHTH; end
        49: begin note = SP; duration = HALF; end
        50: begin note = D3; duration = EIGHTH; end
        51: begin note = SP; duration = SIXTEENTH; end
        52: begin note = F3; duration = EIGHTH; end
        53: begin note = SP; duration = SIXTEENTH; end 
        54: begin note = F3; duration = EIGHTH; end 
        55: begin note = SP; duration = SIXTEENTH; end
        56: begin note = SP; duration = SIXTEENTH; end
        57: begin note = SP; duration = SIXTEENTH; end
        58: begin note = SP; duration = SIXTEENTH; end //end 5th MEASURE
        default: begin note = C4; duration = FOUR; end

        endcase 
        end
        3:begin
        case(number) //THIS IS ODE 2 JOY
        0: begin note = B4; duration = EIGHTH; end //START FIRST MEASURE
        1: begin note = SP; duration = SIXTEENTH; end 
        2: begin note = B4; duration = EIGHTH; end //
        3: begin note = SP; duration = SIXTEENTH; end 
        4: begin note = C4; duration = EIGHTH; end //
        5: begin note = SP; duration = SIXTEENTH; end
        6: begin note = D4; duration = EIGHTH; end //
        7: begin note = SP; duration = SIXTEENTH; end //END FIRST MEASURE
        8: begin note = D4; duration = EIGHTH; end // START SECOND MEASURE
        9: begin note = SP; duration = SIXTEENTH; end //
        10: begin note = C4; duration = EIGHTH; end //
        11: begin note = SP; duration =  SIXTEENTH; end
        12: begin note = B4; duration =  EIGHTH; end //
        13: begin note = SP; duration =  SIXTEENTH; end
        14: begin note = A4; duration =  EIGHTH; end //
        15: begin note = SP; duration =  SIXTEENTH; end // END SECOND MEASURE
        16: begin note = G3; duration =  EIGHTH; end // START THIRD MEASURE
        17: begin note = SP; duration =  SIXTEENTH; end
        18: begin note = G3; duration = SIXTEENTH; end //
        19: begin note = SP; duration = SIXTEENTH; end //
        20: begin note = A4; duration = EIGHTH; end //
        21: begin note = SP; duration = SIXTEENTH; end //
        22: begin note = B4; duration = SIXTEENTH; end //
        23: begin note = SP; duration = SIXTEENTH; end // END THIRD MEASURE
        24: begin note = B4; duration = HALF; end //START FOURTH MEASURE
        25: begin note = SP; duration = SIXTEENTH; end
        26: begin note = A4; duration = SIXTEENTH; end //
        27: begin note = SP; duration = SIXTEENTH; end
        28: begin note = A4; duration = EIGHTH; end //
        29: begin note = SP; duration = SIXTEENTH; end //END 4TH MEASURE
        30: begin note = B4; duration = EIGHTH; end //START 5TH MEASURE
        31: begin note = SP; duration = SIXTEENTH; end //
        32: begin note = B4; duration = EIGHTH; end //
        33: begin note = SP; duration = SIXTEENTH; end //
        34: begin note = C4; duration = EIGHTH; end //
        35: begin note = SP; duration = SIXTEENTH; end
        36: begin note = D4; duration = EIGHTH; end //
        37: begin note = SP; duration = SIXTEENTH; end //END 5TH MEASURE
        38: begin note = D4; duration = EIGHTH; end // START 6TH MEASURE  
        39: begin note = SP; duration = SIXTEENTH; end
        40: begin note = C4; duration = EIGHTH; end //
        41: begin note = SP; duration = SIXTEENTH; end
        42: begin note = B4; duration = EIGHTH; end 
        43: begin note = SP; duration = SIXTEENTH; end //
        44: begin note = A4; duration = EIGHTH; end //
        45: begin note = SP; duration = SIXTEENTH; end //END 6TH MEASURE
        46: begin note = G3; duration = SIXTEENTH; end // START 7th MEASURE
        47: begin note = SP; duration = SIXTEENTH; end //END FOURTH MEASURE
        48: begin note = G3; duration = SIXTEENTH; end    
        49: begin note = SP; duration = SIXTEENTH; end
        50: begin note = A4; duration = SIXTEENTH; end
        51: begin note = SP; duration = SIXTEENTH; end
        52: begin note = B4; duration = SIXTEENTH; end
        53: begin note = SP; duration = SIXTEENTH; end // end 7th MEASURE
        54: begin note = A4; duration = HALF; end //START EIGHTH MEASURE
        55: begin note = SP; duration = SIXTEENTH; end
        56: begin note = G3; duration = SIXTEENTH; end
        57: begin note = SP; duration = SIXTEENTH; end
        58: begin note = G3; duration = EIGHTH; end //end 8th MEASURE
        default: begin note = C4; duration = FOUR; end
    endcase
  end
endcase
end
endmodule
