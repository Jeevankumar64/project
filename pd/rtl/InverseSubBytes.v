//`include "Inverse_SBOX.sv"



module InvSubBytes(invsub_in,invsub_out);
  input [127:0] invsub_in;
  output [127:0] invsub_out;
  
  wire [7:0] b[16:1];
    
  assign b[1] = invsub_in[127:120];
  assign b[2] = invsub_in[119:112];
  assign b[3] = invsub_in[111:104];
  assign b[4] = invsub_in[103:96];
  assign b[5] = invsub_in[95:88];
  assign b[6] = invsub_in[87:80];
  assign b[7] = invsub_in[79:72];
  assign b[8] = invsub_in[71:64];
  assign b[9] = invsub_in[63:56];
  assign b[10] = invsub_in[55:48];
  assign b[11] = invsub_in[47:40];
  assign b[12] = invsub_in[39:32];
  assign b[13] = invsub_in[31:24];
  assign b[14] = invsub_in[23:16];
  assign b[15] = invsub_in[15:8];
  assign b[16] = invsub_in[7:0];
  
  
  inverseSbox ex1(b[1],invsub_out[127:120]);
  inverseSbox ex2(b[2],invsub_out[119:112]);
  inverseSbox ex3(b[3],invsub_out[111:104]);
  inverseSbox ex4(b[4],invsub_out[103:96]);
  inverseSbox ex5(b[5],invsub_out[95:88]);
  inverseSbox ex6(b[6],invsub_out[87:80]);
  inverseSbox ex7(b[7],invsub_out[79:72]);
  inverseSbox ex8(b[8],invsub_out[71:64]);
  inverseSbox ex9(b[9],invsub_out[63:56]);
  inverseSbox ex10(b[10],invsub_out[55:48]);
  inverseSbox ex11(b[11],invsub_out[47:40]);
  inverseSbox ex12(b[12],invsub_out[39:32]);
  inverseSbox ex13(b[13],invsub_out[31:24]);
  inverseSbox ex14(b[14],invsub_out[23:16]);
  inverseSbox ex15(b[15],invsub_out[15:8]);
  inverseSbox ex16(b[16],invsub_out[7:0]);

  
endmodule

// Testbench for inverseSubBytes

/*
`timescale 1ns/1ps

module tb;
  
  reg [127:0] invsub_in;
  wire [127:0] invsub_out;
  
  
  InvSubBytes dut(invsub_in,invsub_out);
  
  initial
    begin
      
      $monitor($time,"insub_in  = %h ,insub_out  = %h ",invsub_in,invsub_out);
      
      
      invsub_in = 128'b0;
      
      
      #30 invsub_in =   128'h87ec4a8cf26ec3d84d4c46959790e7a6;
      
      #30  invsub_in = 128'b0;
      
           
     end
    
	//Input:=         87ec4a8cf26ec3d84d4c46959790e7a6
//Expected output:=   EA835CF00445332D655D98AD8596B0C5
//Obtained output:=   ea835cf00445332d655d98ad8596b0c5
endmodule
*/
