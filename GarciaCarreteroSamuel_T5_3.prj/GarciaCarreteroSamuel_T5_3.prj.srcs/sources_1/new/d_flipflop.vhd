----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2026 09:26:41 AM
-- Design Name: 
-- Module Name: d_flipflop - Behavioral
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

entity d_flipflop is 
	port(
		clk			: in STD_LOGIC;
		clear		: in STD_LOGIC;
		preset		: in STD_LOGIC;
		data		: in STD_LOGIC;
		z			: out STD_LOGIC
	);
end entity;

architecture Behavioral of d_flipflop is
    signal q_reg : STD_LOGIC := '0';
begin
	process (clk,clear, preset)
	begin
		if clear = '0' then q_reg <= '0';
		elsif preset = '0' then q_reg <= '1';
		elsif rising_edge(clk) then q_reg <= data;
		end if;
	end process;
	
	z <=q_reg;
end architecture;