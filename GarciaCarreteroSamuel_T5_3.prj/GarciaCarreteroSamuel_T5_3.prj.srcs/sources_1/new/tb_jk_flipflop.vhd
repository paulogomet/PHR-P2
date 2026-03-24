library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_jk_flipflop is
end tb_jk_flipflop;

architecture Behavioral of tb_jk_flipflop is
	signal J      : STD_LOGIC := '0';
	signal K      : STD_LOGIC := '0';
	signal CLK    : STD_LOGIC := '0';
	signal PRESET : STD_LOGIC := '0';
	signal CLEAR  : STD_LOGIC := '0';
	signal Q      : STD_LOGIC;
	signal Qn     : STD_LOGIC;
begin
	uut: entity work.jk_flipflop
		port map (
			J      => J,
			K      => K,
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
		J <= '0'; K <= '0'; PRESET <= '0'; CLEAR <= '0';
		wait for 12 ns;

		-- Clear asíncrono
		CLEAR <= '1';
		wait for 2 ns;
		assert (Q = '0' and Qn = '1') report "JK async CLEAR failed" severity error;
		CLEAR <= '0';
		wait for 8 ns;

		-- Preset asíncrono
		PRESET <= '1';
		wait for 2 ns;
		assert (Q = '1' and Qn = '0') report "JK async PRESET failed" severity error;
		PRESET <= '0';
		wait for 8 ns;

		-- J=0, K=0 -> mantiene
		J <= '0'; K <= '0';
		wait until rising_edge(CLK);
		wait for 1 ns;
		assert (Q = '1') report "JK hold (00) failed" severity error;

		-- J=0, K=1 -> reset
		J <= '0'; K <= '1';
		wait until rising_edge(CLK);
		wait for 1 ns;
		assert (Q = '0') report "JK reset (01) failed" severity error;

		-- J=1, K=0 -> set
		J <= '1'; K <= '0';
		wait until rising_edge(CLK);
		wait for 1 ns;
		assert (Q = '1') report "JK set (10) failed" severity error;

		-- J=1, K=1 -> toggle
		J <= '1'; K <= '1';
		wait until rising_edge(CLK);
		wait for 1 ns;
		assert (Q = '0') report "JK toggle first edge failed" severity error;

		wait until rising_edge(CLK);
		wait for 1 ns;
		assert (Q = '1') report "JK toggle second edge failed" severity error;

		-- Prioridad: CLEAR sobre PRESET
		CLEAR <= '1'; PRESET <= '1';
		wait for 2 ns;
		assert (Q = '0') report "JK priority CLEAR over PRESET failed" severity error;
		CLEAR <= '0'; PRESET <= '0';

		assert false report "tb_jk_flipflop completed successfully" severity note;
		wait;
	end process;
end Behavioral;
