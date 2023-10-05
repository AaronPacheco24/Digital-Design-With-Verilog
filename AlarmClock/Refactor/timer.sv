module timer(
        input logic clk, reset,
        output logic max_tick
    );
    
    
    // start from the binary counter and change the next-state logic and anything related to N or 
    logic [26:0] counter;    // signal declaration
    logic [26:0] r_next, r_reg;
    assign counter = 125_000;//1;//125_000;   //1; //SIM ONLY //1;//1;//
    // [1] Register segment
    always_ff @(posedge clk, negedge reset)
    begin
        if(~reset)
            r_reg <= 0;
        else
            r_reg <= r_next;
    end
    
    // [2] next-state logic segment
    always_comb
    begin
        r_next = (r_reg == counter)? 0: r_reg + 1;
    end 
    // [3] output logic segment
    assign max_tick = (r_reg == counter) ? 1'b1: 1'b0;
    
endmodule

// timer [MODULE NAME]
//     ( 
//        .clk(clk),
//
//        .reset(reset),
//        .max_tick()
//    );
    
