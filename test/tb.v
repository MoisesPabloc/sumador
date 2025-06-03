`timescale 1ns / 1ps

module test_tb;

    reg  [7:0] io_in;
    reg        clk;
    wire [15:0] io_out;

    tt_um_alu_prefix_display dut (
        .io_in(io_in),
        .io_out(io_out),
        .clk(clk)
    );

    initial clk = 0;
    always #20 clk = ~clk;  // 25 MHz

    initial begin
        $display("Inicio del testbench");

        io_in = 16'b00000000_00000000;
        #100;

        io_in[7:0]   = 8'b00000101; // A = 5
        io_in[12:8]  = 5'b00011;    // B = 3
        io_in[15:13] = 3'b000;
        io_in[16]    = 1'b0;
        #100;

        io_in[7:0]   = 8'b00001010; // A = 10
        io_in[12:8]  = 5'b00100;    // B = 4
        io_in[15:13] = 3'b001;
        #100;

        $finish;
    end

endmodule
