`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module alarm_clock(
        input logic clk,reset,
        input logic alarmsw,            //En Alarm
        input [3:0]seclow, minlow,   //Seconds low and mins low control
        input [2:0]sechi, minhi,    //seconds high and mins high control
        output [0:7]AN,             //sseg anode selector
        output [6:0]c,              //sseg 
        output audioOut,            //audio out
        output aud_sd,
        output alarmen
        ); 
logic signal;
logic z;
logic [3:0]tsecslo,tsecshi,tminslo,tminshi;

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
        
sseg_driver s_seg 
    (
        .clk(clk),
        .reset(reset),
        .alarmsw(alarmsw),
        .l0({1'b1,tsecslo,1'b1}),
        .l1({1'b1,tsecshi,1'b1}),
        .l2({'b1,tminslo,1'b1}),
        .l3({1'b1,tminshi,1'b1}),
        .l4({1'b1,seclow,1'b1}),
        .l5({2'b10,sechi,1'b1}),
        .l6({1'b1,minlow,1'b1}),
        .l7({2'b10,minhi,1'b1}),
        .c(c),
        .AN(AN),
        .DP(DP),
        .z(z)
    );

SongPlayer songctl
        (
        .clk(clk),
        .z(z),
        .alarmsw(alarmsw),
        .audout(audioOut),
        .audsd(aud_sd)
        );
assign alarmen = alarmsw ? 1'b1 : 1'b0;
endmodule
