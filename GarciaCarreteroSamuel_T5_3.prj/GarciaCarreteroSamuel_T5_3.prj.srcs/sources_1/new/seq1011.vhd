library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seq1011 is
    Port (
        CLK    : in  STD_LOGIC;
        CLEAR  : in  STD_LOGIC;  -- Activo a nivel BAJO ('0' reinicia la máquina a S0)
        PRESET : in  STD_LOGIC;  -- Activo a nivel BAJO ('0' forzaría todo a '1', usar a '1' normalmente)
        X      : in  STD_LOGIC;
        Z      : out STD_LOGIC
    );

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
begin

    -- ==========================================
    -- ECUACIONES COMBINACIONALES (Flujo de Datos)
    -- ==========================================
    
    -- D2 = Q1·Q0·X
    D(2) <= Q(1) and Q(0) and X;
    
    -- D1 = (Q0·X') + (Q1·Q0'·X) + (Q2·X')
    D(1) <= (Q(0) and (not X)) or (Q(1) and (not Q(0)) and X) or (Q(2) and (not X));
    
    -- D0 = (Q0' + Q1')·X
    D(0) <= ((not Q(0)) or (not Q(1))) and X;
    
    -- Salida de Moore: Z = Q2
    Z <= Q(2);

    -- ==========================================
    -- INSTANCIACIÓN DE LOS FLIP-FLOPS
    -- ==========================================
    
    -- Flip-Flop 2 (Bit más significativo)
    FF2: d_flipflop port map (
        clk    => CLK,
        clear  => CLEAR,   -- Conexión directa del puerto exterior
        preset => PRESET,  -- Conexión directa del puerto exterior
        data   => D(2),
        z      => Q(2)
    );

    -- Flip-Flop 1 (Bit intermedio)
    FF1: d_flipflop port map (
        clk    => CLK,
        clear  => CLEAR,
        preset => PRESET,
        data   => D(1),
        z      => Q(1)
    );

    -- Flip-Flop 0 (Bit menos significativo)
    FF0: d_flipflop port map (
        clk    => CLK,
        clear  => CLEAR,
        preset => PRESET,
        data   => D(0),
        z      => Q(0)
    );

end Estructural;