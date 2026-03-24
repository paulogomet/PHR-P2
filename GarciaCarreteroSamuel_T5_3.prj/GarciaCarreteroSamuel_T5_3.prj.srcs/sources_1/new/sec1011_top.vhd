library ieee;
use ieee.std_logic_1164.all;

entity seq1011_top is
    port(
        clk    : in  std_logic;
        clear  : in  std_logic;
        preset : in  std_logic;
        x      : in  std_logic;
        z      : out std_logic
    );
end entity;

architecture structural of seq1011_top is
    signal q1, q0 : std_logic;
    signal d1, d0 : std_logic;
begin
    dp: entity work.seq1011_dp(structural)
        port map(clk => clk, clear => clear, preset => preset, d1 => d1, d0 => d0, q1 => q1, q0 => q0);

    ctrl: entity work.seq1011_ctrl_df(FlujoDatos)
        port map(x => x, q1 => q1, q0 => q0, d1 => d1, d0 => d0, z => z);
end architecture;