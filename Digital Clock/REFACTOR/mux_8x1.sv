`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////

module mux_8x1(
    input logic [5:0] m0,m1,m2,m3,m4,m5,m6,m7,
    input logic [2:0] sel,
    output logic [5:0] f
    );
    always_comb 
    begin
        case (sel)
            3'b000: f = m0;
            3'b001: f = m1;
            3'b010: f = m2;
            3'b011: f = m3;
            3'b100: f = m4;
            3'b101: f = m5;
            3'b110: f = m6;
            3'b111: f = m7;
            default: f= m0;
        endcase
    end
    
    
endmodule
