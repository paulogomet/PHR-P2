library ieee;
use ieee.std_logic_1164.all;

entity tb_seq1011_top is
end;

architecture sim of tb_seq1011_top is
    signal clk    : std_logic := '0';
    signal reset  : std_logic := '1';
    signal x      : std_logic := '0';
    signal z      : std_logic;
begin
    uut: entity work.detector_1011
        port map(CLK => clk, RESET => reset, X => x, Z => z);

    -- reloj: periodo 10 ns
    clk <= not clk after 5 ns;

    -- reset asíncrono al inicio (activo en 1)
    reset <= '1', '0' after 2 ns;

    -- Secuencia 1011011 con solapamiento
    -- Flancos de subida: 5, 15, 25, 35, 45, 55, 65 ns...
    -- Cambiamos x un poco antes de cada flanco (por ejemplo 2 ns antes):
    x <= '0',
         '1' after 3 ns,   -- para flanco 5ns
         '0' after 13 ns,  -- para flanco 15ns
         '1' after 23 ns,  -- para flanco 25ns
         '1' after 33 ns,  -- para flanco 35ns  -> aquí debería salir z=1
         '0' after 43 ns,  -- para flanco 45ns
         '1' after 53 ns,  -- para flanco 55ns
         '1' after 63 ns;  -- para flanco 65ns  -> aquí debería salir z=1

    -- Comprobación automática para 1011011: z esperada = 0001001
    check_proc: process
    begin
        wait until rising_edge(clk); wait for 1 ns;
        assert z = '0' report "z incorrecta en bit 1" severity error;

        wait until rising_edge(clk); wait for 1 ns;
        assert z = '0' report "z incorrecta en bit 2" severity error;

        wait until rising_edge(clk); wait for 1 ns;
        assert z = '0' report "z incorrecta en bit 3" severity error;

        wait until rising_edge(clk); wait for 1 ns;
        assert z = '1' report "z incorrecta en bit 4 (debería detectar 1011)" severity error;

        wait until rising_edge(clk); wait for 1 ns;
        assert z = '0' report "z incorrecta en bit 5" severity error;

        wait until rising_edge(clk); wait for 1 ns;
        assert z = '0' report "z incorrecta en bit 6" severity error;

        wait until rising_edge(clk); wait for 1 ns;
        assert z = '1' report "z incorrecta en bit 7 (detección con solapamiento)" severity error;

        assert false report "tb_seq1011_top completado correctamente" severity note;
        wait;
    end process;

end architecture;