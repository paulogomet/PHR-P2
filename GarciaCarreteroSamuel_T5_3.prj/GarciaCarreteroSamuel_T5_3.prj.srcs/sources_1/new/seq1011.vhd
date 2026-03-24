library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seq1011 is
    Port (
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        X     : in  STD_LOGIC;
        Z     : out STD_LOGIC
    );

<<<<<<< HEAD
<<<<<<< Updated upstream
architecture Estructural of detector_1011 is

    -- 1. Declaramos el componente de tu Flip-Flop D
    component d_flipflop is
        port(
            clk    : in  std_logic;
            clear  : in  std_logic; 
            preset : in  std_logic; 
            data   : in  std_logic;
            z      : out std_logic
        );
    end component;

    -- 2. Declaramos señales para las entradas (D) y salidas (Q) de los 3 Flip-Flops
    signal Q : STD_LOGIC_VECTOR(2 downto 0);
    signal D : STD_LOGIC_VECTOR(2 downto 0);

=======
    
end seq1011;

architecture Behavioral of seq1011 is
    type state_type is (S0, S1, S2, S3, S4);
    signal state, next_state : state_type;
>>>>>>> Stashed changes
=======
architecture Behavioral of detector_1011 is
    type state_type is (S0, S1, S2, S3, S4);
    signal state, next_state : state_type;
>>>>>>> origin/main
begin

    process(CLK, RESET)
    begin
        if RESET = '1' then
            state <= S0;
        elsif rising_edge(CLK) then
            state <= next_state;
        end if;
    end process;

    process(state, X)
    begin
        case state is

            when S0 =>
                if X = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;

            when S1 =>
                if X = '0' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;

            when S2 =>
                if X = '1' then
                    next_state <= S3;
                else
                    next_state <= S0;
                end if;

            when S3 =>
                if X = '1' then
                    next_state <= S4;
                else
                    next_state <= S2;
                end if;

            when S4 =>
                if X = '1' then
                    next_state <= S1;
                else
                    next_state <= S2;
                end if;

        end case;
    end process;

    Z <= '1' when state = S4 else '0';

end Behavioral;