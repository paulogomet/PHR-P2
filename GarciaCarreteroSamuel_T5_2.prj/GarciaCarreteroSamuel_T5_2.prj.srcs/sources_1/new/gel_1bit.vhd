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
    Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Gt_in : in STD_LOGIC;
        Eq_in : in STD_LOGIC;
        Lt_in : in STD_LOGIC;
        
        Gt_out : out STD_LOGIC;
        Eq_out : out STD_LOGIC;
        Lt_out : out STD_LOGIC
    );
end gel_1bit;

architecture Estructural of gel_1bit is

    component not_gate is
        Port (
        A : in STD_LOGIC;
        Z : out STD_LOGIC
        );
    end component;

    component and_gate is
        Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Z : out STD_LOGIC
        );
    end component;

    component or_gate is
        Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Z : out STD_LOGIC
        );
    end component;

    signal not_A, not_B : STD_LOGIC;
    signal Gt_local, Lt_local, Eq_local : STD_LOGIC;
    signal aux_eq1, aux_eq2, aux_gt1, aux_lt1: STD_LOGIC;

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
        A => not_A,
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

    U8 : and_gate port map (
        A => Eq_local,
        B => Gt_in,
        Z => aux_gt1
    );

    U9 : or_gate port map (
        A => Gt_local,
        B => aux_gt1,
        Z => Gt_out
    );

    U10 : and_gate port map (
        A => Eq_local,
        B => Lt_in,
        Z => aux_lt1
    );

    U11 : or_gate port map (
        A => aux_lt1,
        B => Lt_local,
        Z => Lt_out
    );

    U12 : and_gate port map (
        A => Eq_local,
        B => Eq_in,
        Z => Eq_out
    );


end Estructural;
