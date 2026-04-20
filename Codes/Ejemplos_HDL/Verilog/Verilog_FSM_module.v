module seq_detector (
    input wire clk,
    input wire rst,
    input wire bit_in,
    output reg seq_detected
);

    // Codificación de estados (1-hot o binaria; usamos binaria)
    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10;

    reg [1:0] state, next_state;

    // Registro de estado
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    // Lógica de transición de estados y salida
    always @(*) begin
        seq_detected = 0;
        case (state)
            S0: begin
                if (bit_in)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (!bit_in)
                    next_state = S2;
                else
                    next_state = S1;
            end
            S2: begin
                if (bit_in) begin
                    next_state = S1;
                    seq_detected = 1;
                end else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule
