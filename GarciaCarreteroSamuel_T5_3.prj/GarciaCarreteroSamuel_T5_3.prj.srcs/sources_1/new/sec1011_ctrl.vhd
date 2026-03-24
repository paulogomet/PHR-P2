library ieee;
use ieee.std_logic_1164.all;

entity seq1011_ctrl is
    port(
        x  : in  std_logic;
        q1 : in  std_logic;
        q0 : in  std_logic;
        d1 : out std_logic;
        d0 : out std_logic;
        z  : out std_logic
    );
end entity;

architecture FlujoDatos of seq1011_ctrl is
    signal state   : std_logic_vector(1 downto 0);
    signal state_x : std_logic_vector(2 downto 0);
begin
    state   <= q1 & q0;
    state_x <= state & x;

    with state_x select
        d1 <=
            -- S0: x=0 -> S0(00), x=1 -> S1(01)
            '0' when "000",
            '0' when "001",

            -- S1(01): x=0 -> S2(10), x=1 -> S1(01)
            '1' when "010",
            '0' when "011",

            -- S2(10): x=0 -> S0(00), x=1 -> S3(11)
            '0' when "100",
            '1' when "101",

            -- S3(11): x=0 -> S2(10), x=1 -> S1(01) (solapamiento)
            '1' when "110",
            '0' when "111",

            '0' when others;

    -- d0 (bit bajo del next_state)
    with state_x select
        d0 <=
            -- S0
            '0' when "000",
            '1' when "001",

            -- S1
            '0' when "010",
            '1' when "011",

            -- S2
            '0' when "100",
            '1' when "101",

            -- S3
            '0' when "110",
            '1' when "111",

            '0' when others;

    -- z = 1 solo cuando estamos en S3(11) y entra x=1  => state_x="111"
    with state_x select
        z <= '1' when "111",
             '0' when others;

end architecture;