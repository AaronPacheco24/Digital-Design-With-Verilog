`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module full_adder
    (
        input logic cin, //carry in
        input logic x,y, // two numbers being added
        output logic s,
        output logic cout
    );
    assign s = x ^ y ^ cin;
    assign Cout = ((x & y) | (x & cin) | (y & cin));   
endmodule
