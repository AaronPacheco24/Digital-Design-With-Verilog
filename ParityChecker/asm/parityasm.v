`timescale 1ns / 1ps
module parityasm(input clock, input load, input [7:0]dataA,output reg serialout, output reg parity,output reg [7:0]registerA);
localparam n=4;
reg [1:0] state_reg;
localparam [1:0] s1=2'b01, s2=2'b10, s3=2'b11;
reg [1:0] state_next;
reg [7:0] registerA_next;
reg serialout_next,done_next,parity_next,done;
reg [2:0]bitcntnxt,bitcnt;
always @(posedge clock)
begin
       if (load)
          begin
             state_reg <= s1;
             //
             registerA<=dataA;
             serialout <=0;
             bitcnt <=0;
             parity<=0;
             done<=0;
          end
       else
          begin
             state_reg <= state_next;
             registerA<=registerA_next;
             serialout<=serialout_next;
             bitcnt<=bitcntnxt;
             done<= done_next;
             parity<=parity_next;
          end
end
always @*
    begin
    state_next = state_reg; 
    registerA_next=registerA;
    serialout_next = serialout;
    done_next=done;
    parity_next = parity;
    bitcntnxt = bitcnt;
    case (state_reg)
        s1:
            begin
                if (load==0)
                begin
                    state_next=s2;
                    done_next=0;
                end
                else
                begin
                   state_next = s1;
                   registerA_next = dataA;
                end
            end 
        s2:
            begin 
                /*if (load == 1)
                begin
                    state_next =s1;
                  
                end*/
                //else 
                //begin
                   /* if (registerA_next == 0)
                    begin
                        state_next = s3; 
                    end
                    else 
                    begin*/
                        state_next = s2;
                        if (registerA_next[7]==1'b1)
                        begin
                            bitcntnxt = bitcnt+1;
                            serialout_next=1;
                        end
                        else
                        begin
                            serialout_next = 0;
                        end
                        registerA_next=registerA<<1;
                        if (registerA_next ==0)
                        begin
                            state_next = s3;
                        end
                    end   
        s3:
            begin
            done_next=1;
            serialout_next=0;
            if (bitcntnxt%2 == 0)
            begin
                parity_next=0;
            end
            else
            begin
                parity_next =1;
            end
            state_next=s3;
            if (load==1)
                state_next=s1;
            end
    
        default:
            begin
                state_next = s1; 
                done_next=0;
            end
    endcase
end
endmodule
