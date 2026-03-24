----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2026 09:30:14 AM
-- Design Name: 
-- Module Name: tb_d_flipflop - Behavioral
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

entity tb_d_flipflop is
end;

architecture Behavioral of tb_d_flipflop is
    signal clk    : STD_LOGIC := '0';
    signal clear  : STD_LOGIC := '1';
    signal preset : STD_LOGIC := '1';
    signal data   : STD_LOGIC := '0';
    signal z      : STD_LOGIC;

begin
    -- DUT
    uut: entity work.d_flipflop
        port map(
            clk    => clk,
            clear  => clear,
            preset => preset,
            data   => data,
            z      => z
        );

    -- reloj 10 ns de periodo
    clk <= not clk after 5 ns;

    stim_proc: process
    begin
        -- clear asíncrono
        clear <= '0'; preset <= '1'; data <= '1';
        wait for 12 ns;
        clear <= '1';
        wait for 10 ns;
        -- preset asíncrono
        preset <= '0';
        wait for 8 ns;
        preset <= '1';
        wait for 10 ns;
        -- captura de data
        data <= '0';
        wait for 20 ns;
        data <= '1';
        wait for 20 ns;
        -- prioridad: clear domina a preset
        clear <= '0'; preset <= '0';
        wait for 10 ns;
        clear <= '1'; preset <= '1';
        wait for 20 ns;
        wait;
    end process;
end architecture;
