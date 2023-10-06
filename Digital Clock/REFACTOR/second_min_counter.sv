`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module second_min_counter
    (
        input logic clk,
        input logic reset,
        input logic insignal,
        output logic [3:0] secslo,secshi,
        output logic [3:0] minslo,minshi
    );
    logic [5:0] second_next,minutes_next,second_reg,minutes_reg;
    always_ff @(posedge clk, negedge reset)
    begin
        if (~reset)
        begin
            second_reg <=0;
            minutes_reg <=0;
        end
        else
        begin
            second_reg <= second_next;
            minutes_reg<= minutes_next;
        end
    end
    
    always_comb
    begin
    second_next= second_reg;
    minutes_next = minutes_reg;
        if (insignal)
        begin
            second_next = second_reg+1;
            if (second_next > 59)
            begin
                second_next  = 0;
                minutes_next = minutes_next + 1;
            end
            else
            begin
                if (minutes_next >= 60)
                    minutes_next = 0;
            end
                
                
        end
    end
        //OUput logic
        assign minshi = minutes_reg / 10;
        assign minslo = minutes_reg % 10;
        assign secshi = second_reg / 10;
        assign secslo = second_reg % 10;

endmodule
