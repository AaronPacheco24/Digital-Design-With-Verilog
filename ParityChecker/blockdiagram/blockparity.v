`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2022 11:14:41 AM
// Design Name: 
// Module Name: lab12_bb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module blockparity(input clock, input load, input [7:0]inreg, output serout, output parity);
wire outsig1hz;
wire select;
wire pbit;
wire notload = ~load;
wire w;
onehzgen stage0(clock, outsig1hz);
shift_gen stage1(outsig1hz,load,inreg,w);
pbitgen stage2(outsig1hz,notload,w,pbit);
counting stage3( notload, outsig1hz, select);
multiplex stage4(select,w,pbit,serout,parity);

endmodule
module onehzgen(input clk, output reg outsig);
reg [26:0] counter;
always @ (posedge clk)
begin 
counter = counter +1;
if (counter == 50_000_000)
    begin
        outsig = ~outsig;
        counter = 0;
    end
end
endmodule
module shift_gen(onehz,loadvar,rgster, z);
input onehz,loadvar;
input [7:0] rgster;
output reg z;
reg bitcount;
reg [7:0]loadedval;
always@ (posedge onehz)
begin
    if (loadvar == 1)
    begin
        loadedval = rgster;
        z = 0;
    end
    else
    begin 
        z = loadedval[0];
        loadedval = loadedval >>1;
    end
end
endmodule
module pbitgen(onehz,reset,z,pty);
input z;
input onehz,reset;
output reg pty;
always@ (posedge onehz)
begin 
if (reset ==0) 
begin
    pty<=1; 
end
else
begin 
    if (z==1 ) begin
       pty<=~pty; end   
end
end
endmodule
module counting(clear,insig,slct);
input clear,insig;
reg[2:0] andcnt;
reg done;
output reg slct;
always @ (posedge insig)
begin
    if (clear ==0)
    begin
        andcnt = 0;
        slct=0;
        done =0;
    end
    else
    begin
    if (done ==1) begin
        andcnt <=andcnt+1;
        if (andcnt == 3'b111)
        begin 
            slct = 1;
            done =1;
        end
        else
        begin 
            slct =0;
        end end
    end
end
endmodule
module multiplex(sel,z,p,serialout,par);
input sel,z,p;
output reg serialout,par;
always @ * 
begin
case(sel)
    0: begin serialout = z; par = p; end
    1: begin par = p;end
    default:  begin serialout = z; par = p; end
endcase
end
endmodule
