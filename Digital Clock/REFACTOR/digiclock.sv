`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module digiclock
    (
        input logic clk,reset,
        output logic [0:7] AN,
        output logic [6:0] C,
        output logic DP
    );
    
    logic [3:0]secslo,secshi,minslo,minshi;
    onehzgen onesec
        (
            .clk(clk),
            .reset(reset),
            .signal(signal)
        );
    second_min_counter secmin
        (
            .clk(clk),
            .reset(reset),
            .insignal(signal),
            .*
        );
    
    
    sseg_driver sseg 
        (
            .clk(clk),
            .reset(reset),
            .l0({1'b1,secslo,1'b1}),
            .l1({1'b1,secshi,1'b1}),
            .l2({1'b1,minslo,1'b1}),
            .l3({1'b1,minshi,1'b1}),
            .l4(7'd0),
            .l5(7'd0),
            .l6(7'd0),
            .l7(7'd0),
            .C(C),
            .AN(AN),
            .DP(DP)
        );
endmodule
