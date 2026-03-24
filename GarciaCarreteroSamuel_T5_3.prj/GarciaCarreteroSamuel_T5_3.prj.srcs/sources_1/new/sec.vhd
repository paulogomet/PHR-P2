library ieee;
use ieee.std_logic_1164.all;

entity sec is
    port(
        clk    : in  std_logic;
        clear  : in  std_logic;
        preset : in  std_logic;
        d1     : in  std_logic;  
        d0     : in  std_logic;  
        q1     : out std_logic;  
        q0     : out std_logic   
    );
end entity;

architecture structural of sec is
begin
    ff1: entity work.ff_d(FlujoDatos)
        port map(clk => clk, clear => clear, preset => preset, data => d1, z => q1);

    ff0: entity work.ff_d(FlujoDatos)
        port map(clk => clk, clear => clear, preset => preset, data => d0, z => q0);
end architecture;