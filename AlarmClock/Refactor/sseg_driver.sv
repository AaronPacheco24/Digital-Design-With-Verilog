`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module sseg_driver
    (
        input logic clk,reset,
        input logic [5:0]l0,l1,l2,l3,l4,l5,l6,l7,
        input logic alarmsw,
        output logic [6:0] c,
        output logic [0:7] AN,
        output logic DP,
        output logic z
    );
    
    logic max_tick;
    logic [2:0] mux_sel;
    logic [5:0] mux_output;

    timer timer0 
    (
        .clk(clk),
        .reset(reset),
        .max_tick(max_tick)
    );
    
    udl_counter #(.BITS(3)) mux_select 
    (
        .clk(clk), // All on same clock
        .reset(reset), // Global reset
        .enable(max_tick), // When ticker finishes. We count up
        .up(1), // Always count up
        .load(), // Never load
        .D(), 
        .Q(mux_sel) // fast selector for display mux.
    );
    
    decoder_generic #(.N(3)) andec 
    (
        .w(mux_sel),
        .en(mux_output[5]),
        .y(AN)
    );
   
    mux_8x1 mux8x1 
    (
        .m0(l0),
        .m1(l1),
        .m2(l2),
        .m3(l3),
        .m4(l4),
        .m5(l5),
        .m6(l6),
        .m7(l7),
        .sel(mux_sel),
        .f(mux_output)
    );
    
    dec_2_sseg sseg 
    (
        .dec(mux_output[4:1]),
        .sseg(c)
    );
   
    alarm_sound_logic alarmlog
    (  
        .z(z),
        .alarmsw(alarmsw),
        .*
    );  
    
    
    assign DP = mux_output[0];

endmodule
