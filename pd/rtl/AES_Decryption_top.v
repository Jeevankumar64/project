/*
`include "Key_Expantion.sv"
`include "InverseShiftRows.sv"  
`include "InverseSubBytes.sv"   
`include "InverseMixColumn.sv"  
`include "DecryAdd_RoundKey.sv" 
`include "g_function.sv"
`include "S_Box.sv"
`include "Inverse_SBOX.sv"
`include "decLastround.sv"
`include "DecrypRounds.sv"
//`include "AES_Decryption_top.sv"
//`include "ECC_Decryption.sv"
*/


module AES_Decryption(clk,rst,Cipher_test,Aes_key,plain_text,Done);
  input clk,rst;
  input [127:0] Cipher_test;
  input [127:0] Aes_key;
  output [127:0] plain_text;
  output Done;
  
  wire [127:0] round_in[0:9];
  wire [127:0] key_in,key_s1,key_s2,key_s3,key_s4,key_s5,key_s6,key_s7,key_s8,key_s9,key_s10,key_s11;
   
  assign key_in = Aes_key; 
  
  key_Expansion_128 block0(key_in,key_s1,key_s2,key_s3,key_s4,key_s5,key_s6,key_s7,key_s8,key_s9,key_s10,key_s11);
 
  assign round_in[0]= Cipher_test ^ key_s11;
  
  deRounds block1(clk,rst,round_in[0] , key_s10, round_in[1] );
  deRounds block2(clk,rst,round_in[1]  , key_s9, round_in[2] );
  deRounds block3(clk,rst,round_in[2]  , key_s8, round_in[3] );
  deRounds block4(clk,rst,round_in[3]  , key_s7, round_in[4] );
  deRounds block5(clk,rst,round_in[4]  , key_s6, round_in[5] );
  deRounds block6(clk,rst,round_in[5]  , key_s5, round_in[6] );
  deRounds block7(clk,rst,round_in[6]  , key_s4, round_in[7] );
  deRounds block8(clk,rst,round_in[7]  , key_s3, round_in[8] );
  deRounds block9(clk,rst,round_in[8] , key_s2,  round_in[9] );
  
  deLast_Rounds block10(clk,rst,round_in[9], key_s1,plain_text);
  
  assign Done = (plain_text) ? 1 :0;
endmodule

/*module AEStop_tb;

  reg clk, rst;
  reg [127:0] Cipher_test, Aes_key;
  wire [127:0] plain_text;
  wire Done;

  // Instantiate AES Decryption module with clk & rst
  AES_Decryption dut (
    .clk(clk),
    .rst(rst),
    .Cipher_test(Cipher_test),
    .Aes_key(Aes_key),
    .plain_text(plain_text),
    .Done(Done)
  );

  // Clock Generation (10ns period)
  initial begin
    clk = 0;
    forever #1 clk = ~clk;
  end

  // Stimulus
  initial begin
    $monitor($time, " clk = %b, Plain_text = %h, Aes_key = %h, out = %h", clk,Cipher_test, Aes_key, plain_text);
    $dumpfile("dump.vcd");
    $dumpvars;

    // Reset pulse
    rst = 1;
    Cipher_test = 128'h0;
    Aes_key = 128'h0;
    #10 rst = 0;

    // First test vector
     Cipher_test = 128'hb05cc06948fea128f1207f5c7dcceb7a;
        Aes_key     = 128'h0f1571c947d9e8590cb7add6af7f6798;

    // Back to zeros
    #700 Cipher_test = 128'h0;
        Aes_key     = 128'h0;

      #100 $stop();
  end

endmodule

*/
