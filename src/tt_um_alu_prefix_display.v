module tt_um_alu_prefix_display (
    input  [7:0]  io_in,   // ui[7:0] → A[7:0]
    output [7:0]  io_out,  // uo[7:0] → LED[7:0]
    inout  [7:0]  io_oeb   // uio[7:0]
);

    // Entradas
    wire [7:0] A        = io_in;
    wire       Cin      = io_oeb[0];            // Carry In
    wire [2:0] sel      = io_oeb[3:1];          // Select[2:0]

    // Salidas
    wire [7:0] R;                                // ALU result
    wire       Cout;                             // Carry Out

    // Salida del display (uso de 3 bits de uio para ejemplo)
    wire [2:0] seg3bit;
    assign seg3bit = R[2:0]; // Opcional: mostrar parte del resultado en segmentos

    // Instancias
    ALU alu_inst (
        .A    (A),
        .B    (8'd5),       // puedes conectar una constante o extender otra entrada
        .sel  (sel),
        .R    (R)
    );

    Prefix prefix_inst (
        .A    (A),
        .B    (8'd5),
        .Cin  (Cin),
        .SUM  (),           // sin uso por ahora
        .Cout (Cout)
    );

    // Salidas
    assign io_out = R;

    // Bidireccionales (uio): aquí puedes emular salida si deseas
    assign io_oeb[7] = ~Cout;            // uio[7] = Carry Out (as output)
    assign io_oeb[6:4] = ~seg3bit;       // uio[4-6] = segmento (opcional)
    assign io_oeb[3:0] = 4'b1111;        // uio[3:0] como entradas (alta impedancia)

endmodule
