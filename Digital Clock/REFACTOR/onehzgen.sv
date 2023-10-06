module onehzgen
    (
        input logic clk, 
        input logic reset,
        output logic signal
    );


logic [26:0]counter_reg, counter_next, max_tick;
assign max_tick = 50_000_000;

always_ff @ (posedge clk, negedge reset)
begin 
    if (~reset)
        counter_reg <=0;
    else
        counter_reg <= counter_next;
end

//Next state
assign counter_next = (counter_reg == (max_tick-1))? 0: counter_reg+1;


//Output Logic
assign signal = (counter_reg == (max_tick-1))? 'b1:'b0;
endmodule
