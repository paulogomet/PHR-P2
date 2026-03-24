library ieee;
use ieee.std_logic_1164.all;

-- La entidad de un testbench siempre va vacía
entity tb_reconocedor_1011 is
end entity;

architecture sim of tb_reconocedor_1011 is

    -- 1. Declaración del componente a probar (DUT - Device Under Test)
    component reconocedor_1011 is
        port(
            clk   : in  std_logic;
            clear : in  std_logic;
            X     : in  std_logic;
            Z     : out std_logic
        );
    end component;

    -- 2. Señales internas para conectar con el módulo
    signal clk   : std_logic := '0';
    signal clear : std_logic := '1';
    signal X     : std_logic := '0';
    signal Z     : std_logic;

    -- Definición del periodo de reloj (ej. 10 nanosegundos = 100 MHz)
    constant clk_period : time := 10 ns;

begin

    -- 3. Instanciación del reconocedor
    DUT: reconocedor_1011
        port map (
            clk   => clk,
            clear => clear,
            X     => X,
            Z     => Z
        );

    -- 4. Proceso generador del Reloj
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- 5. Proceso de inyección de estímulos (La prueba en sí)
    stim_proc: process
    begin
        clear <= '0';
        X     <= '0';
        wait for 15 ns; 
        clear <= '1'; -- Desactivamos el reset para que la máquina empiece a funcionar
        wait for 5 ns;

        
        -- Inyectamos: '1'
        X <= '1'; wait for clk_period;
        -- Inyectamos: '0'
        X <= '0'; wait for clk_period;
        -- Inyectamos: '1'
        X <= '1'; wait for clk_period;
        -- Inyectamos: '1' -> ¡AQUÍ SE COMPLETA EL PRIMER "1011"!
        -- (En este ciclo de reloj, Z pasará a '1')
        X <= '1'; wait for clk_period;
        
        -- Inyectamos: '0' (Usamos el '1' anterior como prefijo)
        X <= '0'; wait for clk_period;
        -- Inyectamos: '1'
        X <= '1'; wait for clk_period;
        -- Inyectamos: '1' -> ¡AQUÍ SE COMPLETA EL SEGUNDO "1011" SOLAPADO!
        -- (Z volverá a ponerse a '1')
        X <= '1'; wait for clk_period;

        X <= '0'; wait for clk_period; -- Rompemos la secuencia
        X <= '1'; wait for clk_period;
        X <= '0'; wait for clk_period;
        X <= '1'; wait for clk_period;
        X <= '0'; wait for clk_period; -- Z debe quedarse en '0' todo el rato

        -- Fin de la simulación
        wait;
    end process;

end architecture;