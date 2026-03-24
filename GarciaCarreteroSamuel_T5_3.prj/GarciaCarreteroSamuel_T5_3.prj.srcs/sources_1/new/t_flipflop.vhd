library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity t_flipflop is
    Port (
        T       : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        PRESET  : in  STD_LOGIC;
        CLEAR   : in  STD_LOGIC;
        Q       : out STD_LOGIC;
        Qn      : out STD_LOGIC
    );
end t_flipflop;

architecture Dataflow of t_flipflop is
    signal Q_int  : STD_LOGIC := '0';
    signal Q_next : STD_LOGIC;
begin

    -- 🔹 ECUACIÓN T (FLUJO DE DATOS)
    Q_next <= T xor Q_int;

    -- 🔹 MEMORIA (registro)
    process(CLK, PRESET, CLEAR)
    begin
        if CLEAR = '1' then
            Q_int <= '0';
        elsif PRESET = '1' then
            Q_int <= '1';
        elsif rising_edge(CLK) then
            Q_int <= Q_next;
        end if;
    end process;

    -- 🔹 SALIDAS
    Q  <= Q_int;
    Qn <= not Q_int;

end Dataflow;