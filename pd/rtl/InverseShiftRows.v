
// The below code is for inverse Shift Rows

module InvshiftRows(invsr_in,invsr_out);
  
  input [127:0] invsr_in;
  output [127:0] invsr_out;
  
  wire [7:0] b[1:16];
  
  
  assign b[1] = invsr_in[127:120];
  assign b[2] = invsr_in[119:112];
  assign b[3] = invsr_in[111:104];
  assign b[4] = invsr_in[103:96];
  assign b[5] = invsr_in[95:88];
  assign b[6] = invsr_in[87:80];
  assign b[7] = invsr_in[79:72];
  assign b[8] = invsr_in[71:64];
  assign b[9] = invsr_in[63:56];
  assign b[10] = invsr_in[55:48];
  assign b[11] = invsr_in[47:40];
  assign b[12] = invsr_in[39:32];
  assign b[13] = invsr_in[31:24];
  assign b[14] = invsr_in[23:16];
  assign b[15] = invsr_in[15:8];
  assign b[16] = invsr_in[7:0];
  
  assign invsr_out[127:120]    =  b[1] ;
  assign invsr_out[119:112]    =  b[14] ;
  assign invsr_out[111:104]    =  b[11] ;
  assign invsr_out[103:96]     =  b[8] ;
  assign invsr_out[95:88]      =  b[5] ;
  assign invsr_out[87:80]      =  b[2] ;
  assign invsr_out[79:72]      =  b[15] ;
  assign invsr_out[71:64]      =  b[12] ;
  assign invsr_out[63:56]      =  b[9] ;
  assign invsr_out[55:48]      =  b[6] ;
  assign invsr_out[47:40]      =  b[3] ;
  assign invsr_out[39:32]      =  b[16] ;
  assign invsr_out[31:24]      =  b[13] ;
  assign invsr_out[23:16]      =  b[10] ;
  assign invsr_out[15:8]       =  b[7] ;
  assign invsr_out[7:0]        =  b[4] ;
  
endmodule

// Test bench for Inverse Shift Rows

/*
`timescale 1ns/1ps

module InverseShiftRow_tb;
  
    reg [127:0] invsr_in;
  wire [127:0] invsr_out;
  
  InvshiftRows dut(invsr_in,invsr_out);
  
  initial 
  begin
    
    $monitor($time," Input = %H, Output = %h ",invsr_in,invsr_out);
    invsr_in = 128'h0; 
   
    
    #30 
    invsr_in = 128'h876E46A6F24CE78C4D904AD897ECC395; 
   
    //Expected OUTPUT := 87EC4A8CF26EC3D84D4C46959790E7A6
    //obtained output := 87ec4a8cf26ec3d84d4c46959790e7a6
    
    #30 invsr_in = 128'h0; 
    
    #50 $stop();
    
   
  end
endmodule

*/
