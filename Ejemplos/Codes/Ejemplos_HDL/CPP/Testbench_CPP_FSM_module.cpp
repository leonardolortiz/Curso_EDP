int main() {
    SeqDetector fsm;

    std::vector<bool> input_sequence = {1, 0, 1, 0, 1, 1, 0, 1};
    std::cout << "Time | In | State | Detected\n";
    std::cout << "-----------------------------\n";

    for (size_t t = 0; t < input_sequence.size(); ++t) {
        bool bit_in = input_sequence[t];
        fsm.clock_tick(bit_in);
        std::cout << "  " << t << "   | " << bit_in << "  | "
                  << fsm.state_str() << "   |   "
                  << fsm.output() << "\n";
    }

    return 0;
}
