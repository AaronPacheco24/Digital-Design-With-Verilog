`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module alarm_sound_logic
    (
        input logic clk,
        input logic reset,
        input logic alarmsw,
        input logic [5:0] l0,l1,l2,l3,l4,l5,l6,l7,
        output logic z
    );
    
    //Signal Declaration
    logic z_reg,z_next;
    
    //Reg
    always_ff @ (posedge clk, negedge reset)
    begin
        if (~reset)
            z_reg<=0;
        else
            z_reg <= z_next;
    end
    
    //Next State
    always_comb
    begin
        z_next = z_reg; 
        if (l0 == l4 && l1 == l5 &&
            l2 == l6 && l3 == l7 && alarmsw)
            z_next = 1;
        else if (z == 1 && alarmsw)
            z_next = 1;
        else if (z==1 && ~alarmsw)
            z_next = 0; 
        else
            z_next =0;
    end
    
    //Output 
    assign z = z_reg;
    
endmodule
