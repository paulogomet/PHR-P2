library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_not_gate is
end tb_not_gate;

architecture Behavioral of tb_not_gate is
	signal A : STD_LOGIC := '0';
	signal Z : STD_LOGIC;
begin
	uut: entity work.not_gate
		port map (
			A => A,
			Z => Z
		);

	stim_proc: process
	begin
		A <= '0';
		wait for 10 ns;
		assert (Z = '1') report "NOT 0 failed" severity error;

		A <= '1';
		wait for 10 ns;
		assert (Z = '0') report "NOT 1 failed" severity error;

		assert false report "tb_not_gate completed successfully" severity note;
		wait;
	end process;
end Behavioral;
