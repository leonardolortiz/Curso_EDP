library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_seq_detector is
end tb_seq_detector;

architecture testbench of tb_seq_detector is

    signal clk          : std_logic := '0';
    signal rst          : std_logic := '0';
    signal bit_in       : std_logic := '0';
    signal seq_detected : std_logic;

    -- Componente a testear
    component seq_detector is
        Port (
            clk          : in  std_logic;
            rst          : in  std_logic;
            bit_in       : in  std_logic;
            seq_detected : out std_logic
        );
    end component;

begin

    -- Instancia del DUT
    uut: seq_detector
        port map (
            clk          => clk,
            rst          => rst,
            bit_in       => bit_in,
            seq_detected => seq_detected
        );

    -- Generador de reloj (10 ns de período)
    clk_process: process
    begin
        while true loop
            clk <= '0'; wait for 5 ns;
            clk <= '1'; wait for 5 ns;
        end loop;
    end process;

    -- Estímulo de prueba
    stim_proc: process
    begin
        -- Reset inicial
        rst <= '1';
        wait for 12 ns;
        rst <= '0';

        -- Aplicamos la secuencia: 1 0 1 → debe detectarse en el tercer bit
        bit_in <= '1'; wait for 10 ns;
        bit_in <= '0'; wait for 10 ns;
        bit_in <= '1'; wait for 10 ns;

        -- Continuamos para ver múltiples detecciones
        bit_in <= '0'; wait for 10 ns;
        bit_in <= '1'; wait for 10 ns;
        bit_in <= '1'; wait for 10 ns;
        bit_in <= '0'; wait for 10 ns;
        bit_in <= '1'; wait for 10 ns;

        wait for 20 ns;

        -- Fin de simulación
        wait;
    end process;

end testbench;
