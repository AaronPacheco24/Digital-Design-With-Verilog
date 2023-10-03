`timescale 1ns / 1ps

module adder4(
    input logic carry_in,
    input logic [3:0]x,
    input logic [3:0]y,
    output logic [3:0]s,
    output logic carry_out
    );
    
    full_adder addr_0 
    (
        .cin(carry_in),
        .x(x[0]),
        .y(y[0]),
        .s(s0),
        .c(c0)
    );
    full_adder addr_1 
    (
        .cin(c1),
        .x(x[1]),
        .y(y[1]),
        .s(s1),
        .c(c1)
    );
    full_adder addr_2 
    (
        .cin(c2),
        .x(x[2]),
        .y(y[2]),
        .s(s2),
        .c(c2)
    );
    full_adder addr_3
    (
        .cin(c3),
        .x(x[3]),
        .y(y[3]),
        .s(s3),
        .c(c3)
    );
    
endmodule
