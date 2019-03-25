module ecc_decryption (
    input clk,
    input rst,
    input [255:0] C1,  // Cipher text C1
    input [255:0] C2,  // Cipher text C2
    input [255:0] d,   // Private Key
    output reg [127:0] M, // Decrypted message
    output reg Done
);

    wire [255:0] dC1;
    wire Done1;

    multiplier k1(clk, rst, d, C1, Done1, dC1);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            M <= 128'b0;
            Done <= 1'b0;
        end else if (Done1) begin
            M <= C2[127:0] ^ dC1[127:0]; // Assuming message is in lower 128 bits
            Done <= 1'b1;
        end
    end
endmodule

module multiplier (
    input clk,
    input Reset,
    input [255:0] a, b,
    output reg Done,
    output [255:0] product
);

    reg [255:0] a_in, count_in;
    reg [257:0] b_in, c_in;
    reg a_load, b_load, c_load, count_load;

    wire [255:0] a_out, count_out;
    wire [257:0] b_out, c_out;

    reg_256 r1 (.clk(clk), .Load(a_load), .Data(a_in), .Out(a_out));
    reg_256 #(258) r2 (.clk(clk), .Load(b_load), .Data(b_in), .Out(b_out));
    reg_256 #(258) r3 (.clk(clk), .Load(c_load), .Data(c_in), .Out(c_out));
    reg_256 #(256) count (.clk(clk), .Load(count_load), .Data(count_in), .Out(count_out));

    reg [2:0] State, Next_State;
    parameter Init = 3'b000, Start = 3'b001, setB = 3'b010, redB = 3'b011, setC = 3'b100, Finish = 3'b101;

    reg [255:0] product_reg;
    assign product = product_reg;

    wire [257:0] P = {2'b00, 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F};

    always @(posedge clk) begin
        if (Reset)
            State <= Init;
        else
            State <= Next_State;
    end

    always @(*) begin
        // Default assignments
        Next_State = State;
        count_in = count_out;
        b_in = b_out;
        c_in = c_out;
        a_in = a_out;
        count_load = 1'b0;
        a_load = 1'b0;
        b_load = 1'b0;
        c_load = 1'b0;

        case (State)
            Init: begin
                Next_State = Start;
                count_in = 8'b0;
                a_in = a;
                b_in = {2'b00, b};
                c_in = 258'b0;
                count_load = 1'b1;
                a_load = 1'b1;
                b_load = 1'b1;
                c_load = 1'b1;
            end

            Start: begin
                c_in = (a[0] == 1'b1) ? b_out : 258'b0;
                c_load = 1'b1;
                Next_State = setB;
            end

            setB: begin
                a_in = a_out >> 1;
                b_in = b_out << 1;
                a_load = 1'b1;
                b_load = 1'b1;
                if ((b_out << 1) >= P)
                    Next_State = redB;
                else
                    Next_State = setC;
            end

            redB: begin
                if (b_out >= P)
                    b_in = b_out - P;
                else
                    b_in = b_out;
                b_load = 1'b1;
                if ((b_out - P) >= P)
                    Next_State = redB;
                else
                    Next_State = setC;
            end

            setC: begin
                if (a_out[0] == 1'b1)
                    c_in = (c_out + b_out >= P) ? (c_out + b_out - P) : (c_out + b_out);
                else
                    c_in = c_out;

                c_load = 1'b1;
                count_in = count_out + 1;
                count_load = 1'b1;

                if (count_out == 8'd254)
                    Next_State = Finish;
                else
                    Next_State = setB;
            end

            Finish: begin
                // stay in Finish
                Next_State = Finish;
            end
        endcase
    end

    always @(posedge clk) begin
        if (Reset) begin
            Done <= 0;
            product_reg <= 0;
        end else if (State == Finish) begin
            if (c_out < P) begin
                product_reg <= c_out[255:0];
                Done <= 1;
            end else begin
                c_in <= c_out - P;
                c_load <= 1;
                Done <= 0;
            end
        end else begin
            Done <= 0;
        end
    end
endmodule
module reg_256 #(parameter size = 256) (
    input clk,
    input Load,
    input [size-1:0] Data,
    output reg [size-1:0] Out
);
    always @(posedge clk) begin
        if (Load)
            Out <= Data;
    end
endmodule

