library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_t_flipflop is
end tb_t_flipflop;

architecture Behavioral of tb_t_flipflop is
	signal T      : STD_LOGIC := '0';
	signal CLK    : STD_LOGIC := '0';
	signal PRESET : STD_LOGIC := '0';
	signal CLEAR  : STD_LOGIC := '0';
	signal Q      : STD_LOGIC;
	signal Qn     : STD_LOGIC;
begin
	uut: entity work.t_flipflop
		port map (
			T      => T,
			CLK    => CLK,
			PRESET => PRESET,
			CLEAR  => CLEAR,
			Q      => Q,
			Qn     => Qn
		);

	clk_proc: process
	begin
		while true loop
			CLK <= '0';
			wait for 5 ns;
			CLK <= '1';
			wait for 5 ns;
		end loop;
	end process;

	stim_proc: process
	begin
		-- Estado inicial
		T <= '0'; PRESET <= '0'; CLEAR <= '0';
		wait for 12 ns;

		-- Clear asíncrono
		CLEAR <= '1';
		wait for 2 ns;
		assert (Q = '0' and Qn = '1') report "T async CLEAR failed" severity error;
		CLEAR <= '0';
		wait for 8 ns;

		-- Preset asíncrono
		PRESET <= '1';
		wait for 2 ns;
		assert (Q = '1' and Qn = '0') report "T async PRESET failed" severity error;
		PRESET <= '0';
		wait for 8 ns;

		-- T=0 -> mantiene
		T <= '0';
		wait until rising_edge(CLK);
		wait for 1 ns;
		assert (Q = '1') report "T hold (T=0) failed" severity error;

		-- T=1 -> toggle
		T <= '1';
		wait until rising_edge(CLK);
		wait for 1 ns;
		assert (Q = '0') report "T toggle first edge failed" severity error;

		wait until rising_edge(CLK);
		wait for 1 ns;
		assert (Q = '1') report "T toggle second edge failed" severity error;

		-- Prioridad: CLEAR sobre PRESET
		CLEAR <= '1'; PRESET <= '1';
		wait for 2 ns;
		assert (Q = '0') report "T priority CLEAR over PRESET failed" severity error;
		CLEAR <= '0'; PRESET <= '0';

		assert false report "tb_t_flipflop completed successfully" severity note;
		wait;
	end process;
end Behavioral;
