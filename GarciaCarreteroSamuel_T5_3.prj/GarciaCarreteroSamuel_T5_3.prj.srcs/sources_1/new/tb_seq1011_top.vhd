library ieee;
use ieee.std_logic_1164.all;

entity tb_seq1011_top is
end;

architecture sim of tb_seq1011_top is
    signal clk    : std_logic := '0';
    signal clear  : std_logic := '1';
    signal preset : std_logic := '1';
    signal x      : std_logic := '0';
    signal z      : std_logic;
begin
    uut: entity work.seq1011_top
        port map(clk => clk, clear => clear, preset => preset, x => x, z => z);

    -- reloj: periodo 10 ns
    clk <= not clk after 5 ns;

    -- reset asíncrono al inicio (activo en 0)
    clear <= '0', '1' after 12 ns;
    preset <= '1';  -- no lo usamos (se queda inactivo)

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

end architecture;