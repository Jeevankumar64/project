/*
`include "InverseShiftRows.sv"  
`include "InverseSubBytes.sv"   
`include "InverseMixColumn.sv"  
`include "DecryAdd_RoundKey.sv" 
*/


module deLast_Rounds(clk,rst,Rin,keyin,Rout);
  input clk,rst;
  input [127:0] Rin;
  input [127:0] keyin;
  output reg [127:0] Rout;
  
  wire [127:0]invsr_out,out1;
  wire [127:0]invsub_out;
 
  InvshiftRows step1(Rin,invsr_out);
  
  InvSubBytes step2(invsr_out,invsub_out);
  
  AddRound_key step4(invsub_out,keyin,out1);
  
    
  always @(posedge clk) begin
    if(rst) Rout <= 128'b0;
    else begin
     Rout <= out1;
      end
  end

endmodule

/*module Round_tb;
  reg [127:0] Rin,keyin;

  wire [127:0] Rout;
  
   deLast_Rounds dut(Rin,Rout,keyin);

  
  initial begin
    $monitor($time," in1 = %h,  Rout= %h, keyin = %h",Rin,Rout,keyin);
    $dumpfile("dump.vcd");
    $dumpvars;
    
    Rin= 128'h0;
    keyin = 128'h0;
    
    #10  Rin= 128'hEA835CF00445332D655D98AD8596B0C5;    keyin = 128'hAC7766F319FADC2128D12941575C006A;
    
    #30 $stop();
  end
endmodule*/
