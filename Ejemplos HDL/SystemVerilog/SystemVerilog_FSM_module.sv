module seq_detector(
    input wire clk,
    input wire rst,
    input wire bit_in,
    output reg seq_detected
);

    typedef enum reg [1:0] { S0, S1, S2 } state_t;
    state_t state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        seq_detected = 0;
        case (state)
            S0: if (bit_in) next_state = S1;
            S1: if (!bit_in) next_state = S2;
            S2: begin
                if (bit_in) begin
                    next_state = S1;
                    seq_detected = 1;
                end else
                    next_state = S0;
            end
        endcase
    end
endmodule
