library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gel_4bits is
    Port (
        -- Entradas principales (Vectores de 4 bits, de 3 a 0)
        A      : in  STD_LOGIC_VECTOR (3 downto 0);
        B      : in  STD_LOGIC_VECTOR (3 downto 0);
        
        -- Entradas de expansión (Para poder conectar este chip a otro de 4 bits en el futuro)
        Gt_in  : in  STD_LOGIC;
        Eq_in  : in  STD_LOGIC;
        Lt_in  : in  STD_LOGIC;
        
        -- Salidas definitivas del sistema
        Gt_out : out STD_LOGIC;
        Eq_out : out STD_LOGIC;
        Lt_out : out STD_LOGIC
    );
end gel_4bits;

architecture Estructural of gel_4bits is

    -- 1. DECLARACIÓN DEL COMPONENTE (Tu "ladrillo" base)
    component gel_1bit is
        Port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            Gt_in  : in  STD_LOGIC;
            Eq_in  : in  STD_LOGIC;
            Lt_in  : in  STD_LOGIC;
            Gt_out : out STD_LOGIC;
            Eq_out : out STD_LOGIC;
            Lt_out : out STD_LOGIC
        );
    end component;

    -- 2. CABLES INTERNOS (Para la cascada entre los bits)
    -- Usamos vectores de 3 cables para conectar el bit 0 con el 1, el 1 con el 2, y el 2 con el 3.
    signal Gt_casc : STD_LOGIC_VECTOR(2 downto 0);
    signal Eq_casc : STD_LOGIC_VECTOR(2 downto 0);
    signal Lt_casc : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- 3. INSTANCIACIÓN Y CABLEADO (La carrera de relevos)

    -- LSB (Bit 0 - Menos significativo)
    -- Recibe las entradas de expansión generales desde el exterior del chip
    BIT_0: gel_1bit port map (
        A => A(0), 
        B => B(0),
        Gt_in  => Gt_in, 
        Eq_in  => Eq_in, 
        Lt_in  => Lt_in,
        Gt_out => Gt_casc(0), -- Pasa su resultado al cable 0
        Eq_out => Eq_casc(0),
        Lt_out => Lt_casc(0)
    );

    -- Bit 1
    -- Recibe la información del Bit 0 mediante los cables internos
    BIT_1: gel_1bit port map (
        A => A(1), 
        B => B(1),
        Gt_in  => Gt_casc(0), 
        Eq_in  => Eq_casc(0), 
        Lt_in  => Lt_casc(0),
        Gt_out => Gt_casc(1), -- Pasa su resultado al cable 1
        Eq_out => Eq_casc(1),
        Lt_out => Lt_casc(1)
    );

    -- Bit 2
    -- Recibe la información del Bit 1
    BIT_2: gel_1bit port map (
        A => A(2), 
        B => B(2),
        Gt_in  => Gt_casc(1), 
        Eq_in  => Eq_casc(1), 
        Lt_in  => Lt_casc(1),
        Gt_out => Gt_casc(2), -- Pasa su resultado al cable 2
        Eq_out => Eq_casc(2),
        Lt_out => Lt_casc(2)
    );

    -- MSB (Bit 3 - Más significativo)
    -- Recibe la información del Bit 2. 
    -- IMPORTANTE: Sus salidas ya van directamente a los puertos de salida finales.
    BIT_3: gel_1bit port map (
        A => A(3), 
        B => B(3),
        Gt_in  => Gt_casc(2), 
        Eq_in  => Eq_casc(2), 
        Lt_in  => Lt_casc(2),
        Gt_out => Gt_out, 
        Eq_out => Eq_out, 
        Lt_out => Lt_out
    );

end Estructural;