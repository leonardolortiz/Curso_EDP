`timescale 1ns/1ps

module tb_seq_detector;

    reg clk;
    reg rst;
    reg bit_in;
    wire seq_detected;

    // Instancia del módulo a testear (DUT)
    seq_detector dut (
        .clk(clk),
        .rst(rst),
        .bit_in(bit_in),
        .seq_detected(seq_detected)
    );

    // Generador de reloj: periodo de 10 ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Estímulo de entrada
    initial begin
        // Inicialización
        rst = 1;
        bit_in = 0;
        #12;            // Esperamos algo más de un ciclo
        rst = 0;

        // Inyectamos la secuencia: 1 0 1
        #10 bit_in = 1; // ciclo 1
        #10 bit_in = 0; // ciclo 2
        #10 bit_in = 1; // ciclo 3 → aquí debería detectarse

        #10 bit_in = 0; // ciclo 4 (reset automático)
        #10 bit_in = 1; // ciclo 5

        // Fin de la simulación
        #20 $finish;
    end

    // Observador simple
    initial begin
        $monitor("Time=%0t | bit_in=%b | seq_detected=%b | state=%b", 
                  $time, bit_in, seq_detected, dut.state);
    end

endmodule
