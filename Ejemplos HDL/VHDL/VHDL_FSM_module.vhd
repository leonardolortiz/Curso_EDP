library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seq_detector is
    Port (
        clk          : in  STD_LOGIC;
        rst          : in  STD_LOGIC;
        bit_in       : in  STD_LOGIC;
        seq_detected : out STD_LOGIC
    );
end seq_detector;

architecture Behavioral of seq_detector is
    type state_type is (S0, S1, S2);
    signal state, next_state : state_type;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state <= S0;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    process(state, bit_in)
    begin
        seq_detected <= '0';
        case state is
            when S0 =>
                if bit_in = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 =>
                if bit_in = '0' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;
            when S2 =>
                if bit_in = '1' then
                    next_state <= S1;
                    seq_detected <= '1';
                else
                    next_state <= S0;
                end if;
        end case;
    end process;
end Behavioral;
