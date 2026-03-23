----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2026 06:45:21 PM
-- Design Name: 
-- Module Name: gel_1bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gel_1bit is
--  Port ( );
end gel_1bit;

architecture Estructural of gel_1bit is

    component not_gate is
        Port (
        A : in STD_LOGIC;
        Z : out STD_LOGIC;
        );
    end component;

    component and_gate is
        Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Z : out STD_LOGIC;
        );
    end component;

    component or_gate is
        Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Z : out STD_LOGIC;
        );
    end component;

    signal not_A, not_B : STD_LOGIC;
    signal Gt_local, Lt_local, Eq_local : STD_LOGIC;
    signal aux_eq1, aux_eq2 : STD_LOGIC;

begin
    U1 : not_gate port map ( 
        A => A, 
        Z => not_A 
    );

    U2 : not_gate port map ( 
        A => B, 
        Z => not_B 
    );

    U3 : and_gate port map (
        A => A,
        B => not_B,
        Z => Gt_local
    );

    U4 : and_gate port map (
        A => not A,
        B => B,
        Z => Lt_local
    );

    U5 : and_gate port map (
        A => A,
        B => B,
        Z => aux_eq1
    );

    U6 : and_gate port map (
        A => not_A,
        B => not_B,
        Z => aux_eq2
    );

    U7 : or_gate port map (
        A => aux_eq1,
        B => aux_eq2,
        Z => Eq_local
    );


end Estructural;
