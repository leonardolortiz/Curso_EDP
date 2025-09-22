// File: seq_detector.h
#ifndef SEQ_DETECTOR_H
#define SEQ_DETECTOR_H

#include <systemc.h>

SC_MODULE(SeqDetector) {
    // Puertos
    sc_in<bool> clk;
    sc_in<bool> rst;
    sc_in<bool> bit_in;
    sc_out<bool> seq_detected;

    // Estados internos (FSM)
    enum State { S0, S1, S2 };
    sc_signal<State> state;

    // Proceso principal
    void process_fsm() {
        if (rst.read()) {
            state.write(S0);
            seq_detected.write(false);
        } else if (clk.posedge()) {
            State current_state = state.read();
            bool next_detected = false;
            State next_state = current_state;

            switch (current_state) {
                case S0:
                    next_state = (bit_in.read()) ? S1 : S0;
                    break;
                case S1:
                    next_state = (!bit_in.read()) ? S2 : S1;
                    break;
                case S2:
                    if (bit_in.read()) {
                        next_state = S1;
                        next_detected = true;
                    } else {
                        next_state = S0;
                    }
                    break;
            }

            state.write(next_state);
            seq_detected.write(next_detected);
        }
    }

    // Constructor
    SC_CTOR(SeqDetector) {
        SC_METHOD(process_fsm);
        sensitive << clk.pos();
        sensitive << rst;
    }
};

#endif
