`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module dec_2_sseg
    (
    input logic [3:0] dec,
    output logic [6:0] sseg //arranged as gfedcba  
    );
    
    always_comb
    begin
        case(dec)
            0: sseg = 7'b1000000;
            1: sseg = 7'b1111001;                       
            2: sseg = 7'b0100100;             
            3: sseg = 7'b0110000;              
            4: sseg = 7'b0011001;             
            5: sseg = 7'b0010010;             
            6: sseg = 7'b0000010;             
            7: sseg = 7'b1111000;             
            8: sseg = 7'b0000000;             
            9: sseg = 7'b0010000;   
            default: sseg = 7'b1000000;           
        endcase
    end
endmodule
