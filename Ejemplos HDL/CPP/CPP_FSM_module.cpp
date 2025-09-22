#include <iostream>
#include <vector>

enum State { S0, S1, S2 };

class SeqDetector {
private:
    State state;
    bool seq_detected;

public:
    SeqDetector() {
        reset();
    }

    void reset() {
        state = S0;
        seq_detected = false;
    }

    void clock_tick(bool bit_in) {
        seq_detected = false;
        switch (state) {
            case S0:
                state = (bit_in) ? S1 : S0;
                break;
            case S1:
                state = (!bit_in) ? S2 : S1;
                break;
            case S2:
                if (bit_in) {
                    state = S1;
                    seq_detected = true;
                } else {
                    state = S0;
                }
                break;
        }
    }

    bool output() const {
        return seq_detected;
    }

    std::string state_str() const {
        switch (state) {
            case S0: return "S0";
            case S1: return "S1";
            case S2: return "S2";
        }
        return "UNK";
    }
};
