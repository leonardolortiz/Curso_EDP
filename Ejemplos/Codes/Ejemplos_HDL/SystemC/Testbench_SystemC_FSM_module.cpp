#include <systemc.h>
#include "seq_detector.h"

int sc_main(int argc, char* argv[]) {
    // Señales
    sc_signal<bool> rst;
    sc_signal<bool> bit_in;
    sc_signal<bool> seq_detected;
    sc_clock clk("clk", 10, SC_NS);  // Reloj de 10 ns

    // Instancia del módulo
    SeqDetector uut("uut");
    uut.clk(clk);
    uut.rst(rst);
    uut.bit_in(bit_in);
    uut.seq_detected(seq_detected);

    // Trazado de señales (opcional)
    sc_trace_file *wf = sc_create_vcd_trace_file("waveform");
    sc_trace(wf, clk, "clk");
    sc_trace(wf, rst, "rst");
    sc_trace(wf, bit_in, "bit_in");
    sc_trace(wf, seq_detected, "seq_detected");

    // Simulación
    rst = 1;
    bit_in = 0;
    sc_start(12, SC_NS);  // primer ciclo

    rst = 0;

    // Aplicamos secuencia: 1 0 1 → se debe detectar en el tercer bit
    bit_in = 1; sc_start(10, SC_NS);
    bit_in = 0; sc_start(10, SC_NS);
    bit_in = 1; sc_start(10, SC_NS);  // Aquí debe detectarse

    // Más estímulos
    bit_in = 0; sc_start(10, SC_NS);
    bit_in = 1; sc_start(10, SC_NS);
    bit_in = 1; sc_start(10, SC_NS);
    bit_in = 0; sc_start(10, SC_NS);
    bit_in = 1; sc_start(10, SC_NS);  // Otro '101'

    sc_close_vcd_trace_file(wf);

    return 0;
}
