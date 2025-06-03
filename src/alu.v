module ALU (
    input  [7:0] A,
    input  [7:0] B,
    input  [2:0] sel,
    output reg [7:0] R
);

    wire [7:0] sum_result;
    wire       sum_carry;

    Prefix ADDER (
        .A    (A),
        .B    (B),
        .Cin  (1'b0),
        .SUM  (sum_result),
        .Cout (sum_carry)
    );

    always @(*) begin
        case (sel)
            3'b000: R = sum_result;
            3'b001: R = A - B;
            3'b010: R = A & B;
            3'b011: R = A | B;
            3'b100: R = {A[6:0], A[7]};
            3'b101: R = {A[0], A[7:1]};
            default: R = 8'b00000000;
        endcase
    end

endmodule
