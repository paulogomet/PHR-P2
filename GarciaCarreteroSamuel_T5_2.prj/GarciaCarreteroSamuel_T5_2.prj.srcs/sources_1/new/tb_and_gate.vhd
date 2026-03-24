library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_and_gate is
end tb_and_gate;

architecture Behavioral of tb_and_gate is
	signal A : STD_LOGIC := '0';
	signal B : STD_LOGIC := '0';
	signal Z : STD_LOGIC;
begin
	uut: entity work.and_gate
		port map (
			A => A,
			B => B,
			Z => Z
		);

	stim_proc: process
	begin
		A <= '0'; B <= '0';
		wait for 10 ns;
		assert (Z = '0') report "AND 0,0 failed" severity error;

		A <= '0'; B <= '1';
		wait for 10 ns;
		assert (Z = '0') report "AND 0,1 failed" severity error;

		A <= '1'; B <= '0';
		wait for 10 ns;
		assert (Z = '0') report "AND 1,0 failed" severity error;

		A <= '1'; B <= '1';
		wait for 10 ns;
		assert (Z = '1') report "AND 1,1 failed" severity error;

		assert false report "tb_and_gate completed successfully" severity note;
		wait;
	end process;
end Behavioral;
