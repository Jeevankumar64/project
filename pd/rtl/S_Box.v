module S_BOX(q,a);
  input [7:0]q;
  output [7:0]a;
  
  wire [7:0]qd;
  wire [7:0]qdI;
  wire [3:0]b ,c;
  
  wire [3:0]e;//F1 module
  wire [3:0]y;//F2 module
  
  wire [13:0]d;
  
  assign b[3] = q[7] ^ q[5];
  assign b[2] = q[7] ^ q[6] ^ q[4] ^ q[3] ^ q[2] ^ q[1] ;
  assign b[1] = q[7] ^ q[5] ^ q[3] ^ q[2];
  assign b[0] = q[7] ^ q[5]  ^ q[3] ^ q[2] ^ q[1] ;
  
  assign c[3] = q[7] ^ q[6] ^ q[2] ^ q[1] ;
  assign c[2] = q[7]  ^ q[4] ^ q[3] ^ q[2] ^ q[1] ;
  assign c[1] =  q[6] ^ q[4] ^ q[1] ;
  assign c[0] =  q[6] ^ q[1] ^ q[0] ;
  
  assign qd = {b,c};
  
  assign e[3] = (b[0] & ~c[3] ) ^ (b[1] & ~c[2] ) ^ (b[2] & ~c[1] ) ^ (b[2] & c[3] ) ^ (b[3] & c[2] ) ^ (b[3] & c[0] ) ^ (~b[3] & c[3] ) ^ (b[1] & c[3] ) ^ (b[3] & c[1] );
  assign e[2] = (b[0] &  ~c[2] ) ^ (b[3] & ~c[1] ) ^ (~b[2] & c[2] ) ^ (b[2] & c[0] ) ^ (~b[3] & c[3] ) ^ (b[1] & c[3] );
   
  assign e[1] = (c[1] & b[0]) ^ (c[0] & b[1]) ^ (c[2] &  ~b[2]) ^ (c[1] & ~b[1]) ^ (c[3] & b[2]) ^ (~c[2] & b[3]);
  
  assign e[0] = (c[0] & ~b[0]) ^ (c[1] &  ~b[1]) ^ (~c[3] & b[2]) ^ (~c[2] & b[3]) ^ (c[3] & ~b[3]);
  
  assign y[3] = ((~e[0]) & e[3]) ^ (e[1] & e[2] & (~e[3])) ^ ((~e[1]) & e[2]) ; 
  assign y[2] = (e[0] & (~e[2]) & e[3]) ^ (e[1] & e[2] & e[3]) ^ ((~e[1]) & e[2] );  
   assign y[1]  = e[1] ^ (e[0] & e[1] & (~e[2])) ^ e[3] ^ (e[1] & e[2] & (~e[3])) ^ ((~e[0]) & (~e[1]) & e[2]) ^ (e[0] & e[1] & (~e[3]));  
  assign y[0] = (e[1] & e[2]) ^ (e[1] &(~e[2]) &(~e[3]) ^ ((~e[0]) & (~e[1]) & e[2] ) ^ (e[0] & e[1] & e[3]) ^ e[0] &(~e[2]) & (~e[3]));
            
    assign d[0] = b[0] ^ b[1];  
    assign d[1] = b[0] ^ b[2];       
    assign d[2] = b[1] ^ b[3];    
    assign d[3] = b[2] ^ b[3]; 
    assign d[4] = b[3] ^ c[3]; 
    assign d[5] = b[2] ^ c[2];  
    assign d[6] = b[1] ^ c[1];                                                         
    assign d[7] = b[0] ^ c[0];    
    assign d[8] = d[0] ^ d[3]; 
    assign d[9] = d[4] ^ d[5] ^d[6] ^ d[7];                                                      
    assign d[10] = d[4] ^  d[6];    
    assign d[11] = d[4] ^  d[5]; 
    assign d[12] = d[5] ^  d[7]; 
    assign d[13] = d[6] ^  d[7]; 
                                                            
    assign qdI[7] = (y[3] & d[8]) ^ (y[2] & d[2]) ^ (y[1] & d[3]) ^ (y[0] & b[3]);
    assign qdI[6] = (y[3] & d[2]) ^ (y[2] & d[1]) ^ (y[1] & b[3]) ^ (y[0] & b[2]);
   assign qdI[5] = (y[3] & b[2]) ^ (y[2] & d[3]) ^ (y[1] & d[0]) ^ (y[0] & b[1]);
   assign qdI[4] = (y[3] & d[3]) ^ (y[2] & b[3]) ^ (y[1] & b[1]) ^ (y[0] & b[0]);
   assign qdI[3] = (y[3] & d[9]) ^ (y[2] & d[10]) ^ (y[1] & d[11]) ^ (y[0] & d[4]);
   assign qdI[2] = (y[3] & d[10]) ^ (y[2] & d[12]) ^ (y[1] & d[4]) ^ (y[0] & d[5]);
   assign qdI[1] = (y[3] & d[5]) ^ (y[2] & d[11]) ^ (y[1] & d[13]) ^ (y[0] & d[6]);
   assign qdI[0] = (y[3] & d[11]) ^ (y[2] & d[4]) ^ (y[1] & d[6]) ^ (y[0] & d[7]);
                                                            
   assign a[7] = qdI[7]  ^ qdI[3] ^ qdI[2];
   assign a[6] = (~qdI[7]) ^ qdI[6] ^ qdI[5] ^  qdI[4];
   assign a[5] = (~qdI[7]) ^ qdI[2];
                                                            
   assign a[4] = qdI[7] ^ qdI[4] ^ qdI[1] ^ qdI[0];
   assign a[3] = qdI[2] ^ qdI[1] ^ qdI[0];
   assign a[2] = qdI[6] ^ qdI[5] ^ qdI[4] ^ qdI[3] ^ qdI[2] ^ qdI[0];
   assign a[1] = (~qdI[7]) ^ qdI[0];
                                                            
   assign a[0] = (~qdI[7]) ^ qdI[6] ^ qdI[2] ^ qdI[1] ^ qdI[0];
                                                            
 endmodule
 /*module tb ; 
  reg [7:0]q;
  wire [7:0]a;
  
  S_BOX dut(q,a);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    $monitor($time ," q  = %b , q = %h, a  = %b , a = %h",q,q,a,a); 
    #10 q = 8'b00000000;
    
    #40 q = 8'b00000001;
    #10 q = 8'b11110010;
    #10 q = 8'b11110000;
    #10 q = 8'b11110110;
    #10 q = 8'h69;
    #10 q = 8'h72;
    #10 q = 8'h6e;
    #10 q = 8'h67;
    #100 $finish();
  end
endmodule

////////////////////////////////////////////
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

module tb;
  
  reg [31:0] in;
  wire [31:0] out;
  
        Rot_Word dut(in,out);
        
   initial 
     begin
       $monitor($time,"in = %h, out = %h",in,out);
       #20 in = 32'h72696e67;
       #20 in = 32'h696e6772;            	#20 $finish();
       
     end
endmodule


*/
