`timescale 1ns / 1ps


module udl_counter
    #(parameter BITS = 4)(
    input clk,
    input reset,
    input enable,
    input up, //when asserted the counter is up counter; otherwise, it is a down counter
    input load,
    input [BITS - 1:0] D,
    output [BITS - 1:0] Q
    );
    
    reg [BITS - 1:0] Q_reg, Q_next;
    
    always_ff @(posedge clk, negedge reset)
    begin
        if (~reset)
            Q_reg <= 0;
        else if(enable)
            Q_reg <= Q_next;
        else
            Q_reg <= Q_reg;
    end
    
    // Next state logic
    always_comb
    begin
        Q_next = Q_reg + 1;
    end
    
    // Output logic
    assign Q = Q_reg;
endmodule
