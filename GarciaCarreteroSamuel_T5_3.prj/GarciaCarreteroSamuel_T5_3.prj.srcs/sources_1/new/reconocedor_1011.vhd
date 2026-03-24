library ieee;
use ieee.std_logic_1164.all;


entity reconocedor_1011 is
    port(
        clk   : in  std_logic;
        clear : in  std_logic;
        X     : in  std_logic;
        Z     : out std_logic
    );
end entity;

architecture FlujoDatos of reconocedor_1011 is

    component d_flipflop is
        port(
            clk    : in  std_logic;
            clear  : in  std_logic; 
            preset : in  std_logic; 
            data   : in  std_logic;
            z      : out std_logic
        );
    end component;

    signal Q1, Q0 : std_logic;
    signal D1, D0 : std_logic;

begin

    
    D0 <= X;

    D1 <= (Q0 and (not X)) or (Q1 and (not Q0) and X);

    Z <= Q1 and Q0 and X;


   
    FF1: d_flipflop
        port map (
            clk    => clk,
            clear  => clear,
            preset => '1', 
            data   => D1,
            z      => Q1
        );

    FF0: d_flipflop
        port map (
            clk    => clk,
            clear  => clear,
            preset => '1', 
            data   => D0,
            z      => Q0
        );

end architecture;