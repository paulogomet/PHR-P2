library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gel_4bits is
    Port (
        A      : in  STD_LOGIC_VECTOR (3 downto 0);
        B      : in  STD_LOGIC_VECTOR (3 downto 0);
        
        Gt_in  : in  STD_LOGIC;
        Eq_in  : in  STD_LOGIC;
        Lt_in  : in  STD_LOGIC;
        
        Gt_out : out STD_LOGIC;
        Eq_out : out STD_LOGIC;
        Lt_out : out STD_LOGIC
    );
end gel_4bits;

architecture Estructural of gel_4bits is

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

    signal Gt_casc : STD_LOGIC_VECTOR(2 downto 0);
    signal Eq_casc : STD_LOGIC_VECTOR(2 downto 0);
    signal Lt_casc : STD_LOGIC_VECTOR(2 downto 0);

begin


    BIT_0: gel_1bit port map (
        A => A(0), 
        B => B(0),
        Gt_in  => Gt_in, 
        Eq_in  => Eq_in, 
        Lt_in  => Lt_in,
        Gt_out => Gt_casc(0), 
        Eq_out => Eq_casc(0),
        Lt_out => Lt_casc(0)
    );

    
    BIT_1: gel_1bit port map (
        A => A(1), 
        B => B(1),
        Gt_in  => Gt_casc(0), 
        Eq_in  => Eq_casc(0), 
        Lt_in  => Lt_casc(0),
        Gt_out => Gt_casc(1),
        Eq_out => Eq_casc(1),
        Lt_out => Lt_casc(1)
    );

    
    BIT_2: gel_1bit port map (
        A => A(2), 
        B => B(2),
        Gt_in  => Gt_casc(1), 
        Eq_in  => Eq_casc(1), 
        Lt_in  => Lt_casc(1),
        Gt_out => Gt_casc(2), 
        Eq_out => Eq_casc(2),
        Lt_out => Lt_casc(2)
    );

    
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