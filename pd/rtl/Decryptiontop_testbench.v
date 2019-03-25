
module Hybrid_Decryption_Top_tb;

  reg clk;
  reg rst;
  reg [255:0] C1;
  reg [255:0] C2;
  reg [255:0] d;
  reg [127:0] Cipher_test, Aes_key;

  wire [127:0] plain_text;
  wire [127:0] M_out;
  wire Done;

  // Instantiate the hybrid decryption top module
  Hybrid_Decryption_Top uut (
    .clk(clk),
    .rst(rst),
    .C1(C1),
    .C2(C2),
    .d(d),
    .Cipher_test(Cipher_test),
    .plain_text(plain_text),
    .Done(Done),
    .M_out(M_out),
    .Aes_key(Aes_key)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #1 clk = ~clk; // 500MHz clock => 2ns period
  end

  // Stimulus
  initial begin
    $dumpfile("hybrid_decryption_tb.vcd");
    $dumpvars(0, Hybrid_Decryption_Top_tb);

    $display("Starting Hybrid ECC-AES Decryption Testbench...");

    // Real-time monitoring
    $monitor($time, " clk=%b rst=%b | Done=%b | plain_text=%h | M_out=%h", 
              clk, rst, Done, plain_text, M_out);

    // Initialize inputs
    rst = 1;
    C1 = 256'd0;
    C2 = 256'd0;
    d  = 256'd0;
    Cipher_test = 128'd0;
    Aes_key = 128'd0;

    // Apply reset
    #2 rst = 0;

    // Provide test vectors
    C1 = 256'h60ef2fd612b0e1b95e8103cf7e73cbf4ad86726b83ff5350692db588e1497801;
    C2 = 256'ha9e2238787a0b8d6b6cea0cb03ee33d88fa3ced5e4e926c5d0395a05172b8dc3;
    d  = 256'hAABBCCDDEEFF112233445566778899AABBCCDDEEFF00112233445566778899AA;
    Aes_key = 128'h0f1571c947d9e8590cb7add6af7f6798;
    Cipher_test = 128'hb05cc06948fea128f1207f5c7dcceb7a;

    // Wait for decryption to complete
    wait (Done);

    $display("[%0t ns] Decryption Complete!", $time);
    $display("Plain Text = %h", plain_text);
    $display("ECC AES Key (M_out) = %h", M_out);

    $finish;
  end

endmodule
