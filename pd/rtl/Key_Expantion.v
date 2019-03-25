
//`include "g_function.sv"
module key_Expansion_128(key_in,key_s1,key_s2,key_s3,key_s4,key_s5,key_s6,key_s7,key_s8,key_s9,key_s10,key_s11);
  input [127:0] key_in;
  output [127:0] key_s1,key_s2,key_s3,key_s4,key_s5,key_s6,key_s7,key_s8,key_s9,key_s10,key_s11;
  
  reg [31:0] R[1:10]; 
  wire [31:0] g[0:9];
  
  initial 
    begin
      R[1]=32'h01000000;
      R[2]=32'h02000000;
      R[3]=32'h04000000;
      R[4]=32'h08000000;
      R[5]=32'h10000000;
      R[6]=32'h20000000;
      R[7]=32'h40000000;
      R[8]=32'h80000000;
      R[9]=32'h1B000000;
      R[10]=32'h36000000;
    end
  
  
  wire [31:0] ws[0:43];
  

  
  assign ws[0] = key_in[127:96];
  assign ws[1] = key_in[95:64];
  assign ws[2] = key_in[63:32];
  assign ws[3] = key_in[31:0];
  
  g_function gf1(ws[3],R[1],g[0]);
  
  assign ws[4] = ws[0] ^ g[0];
  assign ws[5] = ws[1] ^ ws[4];
  assign ws[6] = ws[2] ^ ws[5];
  assign ws[7] = ws[3] ^ ws[6];
  
  g_function gf2(ws[7],R[2],g[1]);
  
  assign ws[8] = ws[4] ^ g[1];
  assign ws[9] = ws[5] ^ ws[8];
  assign ws[10] = ws[6] ^ ws[9];
  assign ws[11] = ws[7] ^ ws[10];
  
  g_function gf3(ws[11],R[3],g[2]);
  
  assign ws[12] = ws[8] ^ g[2];
  assign ws[13] = ws[9] ^ ws[12];
  assign ws[14] = ws[10] ^ ws[13];
  assign ws[15] = ws[11] ^ ws[14];
  
  g_function gf4(ws[15],R[4],g[3]);

  assign ws[16] = ws[12] ^ g[3];
  assign ws[17] = ws[13] ^ ws[16];
  assign ws[18] = ws[14] ^ ws[17];
  assign ws[19] = ws[15] ^ ws[18];
  
  g_function gf5(ws[19],R[5],g[4]);
  
  assign ws[20] = ws[16] ^ g[4];
  assign ws[21] = ws[17] ^ ws[20];
  assign ws[22] = ws[18] ^ ws[21];
  assign ws[23] = ws[19] ^ ws[22];
  
  g_function gf6(ws[23],R[6],g[5]);
  
  assign ws[24] = ws[20] ^ g[5];
  assign ws[25] = ws[21] ^ ws[24];
  assign ws[26] = ws[22] ^ ws[25];
  assign ws[27] = ws[23] ^ ws[26];
  
  g_function gf7(ws[27],R[7],g[6]);
  
  assign ws[28] = ws[24] ^ g[6];
  assign ws[29] = ws[25] ^ ws[28];
  assign ws[30] = ws[26] ^ ws[29];
  assign ws[31] = ws[27] ^ ws[30];
  
  g_function gf8(ws[31],R[8],g[7]);
  
  assign ws[32] = ws[28] ^ g[7];
  assign ws[33] = ws[29] ^ ws[32];
  assign ws[34] = ws[30] ^ ws[33];
  assign ws[35] = ws[31] ^ ws[34];
  
  g_function gf9(ws[35],R[9],g[8]);
  
  assign ws[36] = ws[32] ^ g[8];
  assign ws[37] = ws[33] ^ ws[36];
  assign ws[38] = ws[34] ^ ws[37];
  assign ws[39] = ws[35] ^ ws[38];
  
  g_function gf10(ws[39],R[10],g[9]);
  
  assign ws[40] = ws[36] ^ g[9];
  assign ws[41] = ws[37] ^ ws[40];
  assign ws[42] = ws[38] ^ ws[41];
  assign ws[43] = ws[39] ^ ws[42];
  
  
 /* assign key_s = {ws[0],ws[1],ws[2],ws[3],ws[4],ws[5],ws[6],ws[7],ws[8],ws[9],ws[10],ws[11],ws[12],ws[13],ws[14],ws[15],ws[16],ws[17],ws[18],ws[19],ws[20],ws[21],ws[22],ws[23],ws[24],ws[25],ws[26],ws[27],ws[28],ws[29],ws[30],ws[31],ws[32],ws[33],ws[34],ws[35],ws[36],ws[37],ws[38],ws[39],ws[40],ws[41],ws[42],ws[43]};*/
  assign key_s1 = {ws[0],ws[1],ws[2],ws[3]};
  assign key_s2 = {ws[4],ws[5],ws[6],ws[7]};
  assign key_s3 = {ws[8],ws[9],ws[10],ws[11]};
  assign key_s4 = {ws[12],ws[13],ws[14],ws[15]};
  assign key_s5 = {ws[16],ws[17],ws[18],ws[19]};
  assign key_s6 = {ws[20],ws[21],ws[22],ws[23]};
  assign key_s7 = {ws[24],ws[25],ws[26],ws[27]};
  assign key_s8 = {ws[28],ws[29],ws[30],ws[31]};
  assign key_s9 = {ws[32],ws[33],ws[34],ws[35]};
  assign key_s10 = {ws[36],ws[37],ws[38],ws[39]};
  assign key_s11 = {ws[40],ws[41],ws[42],ws[43]};
  
endmodule

/*module tb;
  
 reg [127:0] key_in;
  wire [127:0] key_s1,key_s2,key_s3,key_s4,key_s5,key_s6,key_s7,key_s8,key_s9,key_s10,key_s11;
  
 
  
  key_Expansion_128 dut(key_in,key_s1,key_s2,key_s3,key_s4,key_s5,key_s6,key_s7,key_s8,key_s9,key_s10,key_s11);
  
  
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
      #20
      key_in = 128'h736174697368636a6973626f72696e67;
      #50
      key_in = 128'h736174444368636a6973626f72696e67;
      #50
      key_in = 128'h666174444368636a6973626f72696e67;
      #30 $finish();
    end
endmodule
*/
