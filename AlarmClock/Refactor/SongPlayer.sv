module SongPlayer
    (
        input logic clk,
        input logic z,
        input logic alarmsw,
        output logic audout,
        output logic audsd
    );
//Signal Declaration

logic [19:0] counter;
logic [31:0] time1, noteTime;
logic [9:0] msec, number; //millisecond counter, and sequence number of musical note.
logic [4:0] note, duration;
logic [19:0] notePeriod;
parameter clockFrequency = 100_000_000; 
assign aud_sd = 1'b1;

musicSheet  mysong(
    .number(number), 
    .note(notePeriod), 
    .duration(duration)
    );
always @ (posedge clk) 
  begin
if(alarmsw == 0) 
 begin 
          counter <=0;  
          time1<=0;  
          number <=0;  
          audout <=1;
      end
else 
begin
if(z>=1)
begin
counter <= counter + 1; 
time1<= time1+1;
if( counter >= notePeriod) 
   begin
counter <=0;  
audout <= ~audout; 
   end //toggle audio output 
if( time1 >= noteTime) 
begin
time1 <=0;  
number <= number + 1; 
end  //play next note
 if(number == 64) number <=0; // Make the number reset at the end of the song
end
end
  end
         
  always @(duration) noteTime = (duration * clockFrequency/8); 
       //number of   FPGA clock periods in one note. 
endmodule 
