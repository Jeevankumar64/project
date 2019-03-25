module inverseMixColumns(
    input  [127:0] state_in,
    output [127:0] state_out
);

// Multiplication by 2 in GF(2^8)
function [7:0] xtime;
    input [7:0] x;
    begin
        xtime = (x[7]) ? ((x << 1) ^ 8'h1b) : (x << 1);
    end
endfunction

// Multiply by 2^n using xtime repeatedly
function [7:0] multiply;
    input [7:0] x;
    input integer n;
    integer i;
    reg [7:0] result;
    begin
        result = x;
        for (i = 0; i < n; i = i + 1) begin
            result = xtime(result);
        end
        multiply = result;
    end
endfunction

// Multiply by 0x0e = x*8 ^ x*4 ^ x*2
function [7:0] mb0e;
    input [7:0] x;
    begin
        mb0e = multiply(x,3) ^ multiply(x,2) ^ multiply(x,1);
    end
endfunction

// Multiply by 0x0d = x*8 ^ x*4 ^ x
function [7:0] mb0d;
    input [7:0] x;
    begin
        mb0d = multiply(x,3) ^ multiply(x,2) ^ x;
    end
endfunction

// Multiply by 0x0b = x*8 ^ x*2 ^ x
function [7:0] mb0b;
    input [7:0] x;
    begin
        mb0b = multiply(x,3) ^ multiply(x,1) ^ x;
    end
endfunction

// Multiply by 0x09 = x*8 ^ x
function [7:0] mb09;
    input [7:0] x;
    begin
        mb09 = multiply(x,3) ^ x;
    end
endfunction

genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin : mix_col
        wire [7:0] s0, s1, s2, s3;
        assign s3 = state_in[(i*32 + 24)+:8];
        assign s2 = state_in[(i*32 + 16)+:8];
        assign s1 = state_in[(i*32 + 8)+:8];
        assign s0 = state_in[i*32+:8];

        assign state_out[(i*32 + 24)+:8] = mb0e(s3) ^ mb0b(s2) ^ mb0d(s1) ^ mb09(s0);
        assign state_out[(i*32 + 16)+:8] = mb09(s3) ^ mb0e(s2) ^ mb0b(s1) ^ mb0d(s0);
        assign state_out[(i*32 + 8)+:8]  = mb0d(s3) ^ mb09(s2) ^ mb0e(s1) ^ mb0b(s0);
        assign state_out[i*32+:8]       = mb0b(s3) ^ mb0d(s2) ^ mb09(s1) ^ mb0e(s0);
    end
endgenerate

endmodule
