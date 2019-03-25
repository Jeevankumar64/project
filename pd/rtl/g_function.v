// `include "S_Box.sv"
module g_function(win,r_const,wout);
  input [31:0] win;
  input [31:0] r_const;
  output [31:0] wout;
  
  wire [31:0] out,x;
  Rot_Word R1(win,x);
  
  
  S_BOX l1(x[7:0],out[7:0]);
  S_BOX l2(x[15:8],out[15:8]);
  S_BOX l3(x[23:16],out[23:16]);
  S_BOX l4(x[31:24],out[31:24]);
  
  
  assign wout = r_const ^ out;
endmodule

module Rot_Word(in,out);
  input [31:0] in;
  output [31:0] out;
  
  reg [31:0] x;
  always @(*)
    begin
      x ={in[23:16],in[15:8],in[7:0],in[31:24]};
    end
 
  
  assign out = x;
endmodule


/*module tb;
  
  reg [31:0] win;
  reg [31:0] r_const;
  wire [31:0] wout;
  
  g_function dut(win,r_const,wout);
        
   initial 
     begin
       $monitor($time,"in = %h, r_const = %h ,out = %h",win,r_const,wout);
       r_const =32'h01000000;
       #20 win = 32'h72696e67;
       #20 win = 32'h696e6772;            	#20 $finish();
       
     end
endmodule*/
