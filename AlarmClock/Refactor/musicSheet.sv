module musicSheet( 
    input logic [9:0] number, 
    output logic [19:0] note, 
    output logic [4:0] duration
    );
    parameter   QUARTER = 5'b00010;//2
    parameter HALF = 5'b00100;
    parameter ONE = 2* HALF;
    parameter TWO = 2* ONE;
    parameter FOUR = 2* TWO;
    parameter EIGHTH = HALF/2;
    parameter SIXTEENTH = EIGHTH /2;
    parameter A3=227272,A3S=214518,B3=202478,C3=191113,D3S=180384,D3=170262,E3B=160707,E3=151687,F3=143172,F3S=135137,G3=127552,G3S=120393,A4 = 113636, A4S= 107259,B4=101239,C4=95556, D4S=90192, D4=85131, E4B = 80353, E4 = 75843, F4=71586,F4S = 67568, G4 = 63776,G4S=60196,A5=56818,A5S=53629,B5=50619,C5=47778,D5S=45096,D5=42565,E5B=40176,E5=37921,F5=35793,F5S=33784,G5=31888,G5S=30098,A6=28409,SP = 1;  
        always_comb
        begin
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
