`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module decoder_generic
    #(parameter N = 3)
    (
    input logic [N - 1:0] w,
    input logic en,
    output logic [0:2 ** N - 1] y
    );
    logic [0:2**N-1]a;
    always_comb
    begin
        a = 'b0;
        if (en)
            a[w] = 1'b1; 
        else
            a = 'b0;
    end
    assign y = ~a;
endmodule
