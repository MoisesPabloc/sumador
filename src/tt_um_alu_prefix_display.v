module tt_um_alu_prefix_display (
    input  [7:0] io_in,
    output [15:0] io_out,
    input        clk
);

    wire [7:0] sw  = io_in[7:0];
    wire [4:0] sw2 = io_in[12:8];
    wire [2:0] sel = io_in[15:13];
    wire       btnC = io_in[16];

    wire [7:0] led;
    wire       led8;
    wire [6:0] seg;
    wire [3:0] an;

    ALU alu_inst (
        .A    (sw),
        .B    ({3'b000, sw2}),
        .sel  (sel),
        .R    (led)
    );

    Prefix prefix_inst (
        .A    (sw),
        .B    ({3'b000, sw2}),
        .Cin  (btnC),
        .SUM  (),
        .Cout (led8)
    );

    DisplayController display (
        .clk   (clk),
        .value (led),
        .seg   (seg),
        .an    (an)
    );

    assign io_out[7:0]   = led;
    assign io_out[8]     = led8;
    assign io_out[15:9]  = seg;

endmodule
