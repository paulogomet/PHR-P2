----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2026 12:16:56 AM
-- Design Name: 
-- Module Name: tb_gel_4bits - Simulation
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- La entidad de un testbench SIEMPRE está vacía, porque es el laboratorio exterior
entity tb_gel_4bits is
end tb_gel_4bits;

architecture Simulacion of tb_gel_4bits is

    -- 1. Declaramos el chip que vamos a probar (DUT - Device Under Test)
    component gel_4bits is
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
    end component;

    -- 2. Creamos cables internos para enchufarlos a nuestro chip
    -- Los inicializamos a 0 por seguridad
    signal tb_A      : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal tb_B      : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal tb_Gt_in  : STD_LOGIC := '0';
    signal tb_Eq_in  : STD_LOGIC := '0';
    signal tb_Lt_in  : STD_LOGIC := '0';
    
    signal tb_Gt_out : STD_LOGIC;
    signal tb_Eq_out : STD_LOGIC;
    signal tb_Lt_out : STD_LOGIC;

begin

    -- 3. Instanciamos nuestro chip y le conectamos los cables del laboratorio
    UUT: gel_4bits port map (
        A      => tb_A,
        B      => tb_B,
        Gt_in  => tb_Gt_in,
        Eq_in  => tb_Eq_in,
        Lt_in  => tb_Lt_in,
        Gt_out => tb_Gt_out,
        Eq_out => tb_Eq_out,
        Lt_out => tb_Lt_out
    );

    -- 4. El proceso de estímulos (Aquí inyectamos los valores a lo largo del tiempo)
    estimulos: process
    begin
        -- CONFIGURACIÓN INICIAL: 
        -- Como es un chip aislado de 4 bits, forzamos la expansión inicial a "Empate"
        tb_Gt_in <= '0';
        tb_Eq_in <= '1';
        tb_Lt_in <= '0';

        -- CASO 1: A es mayor que B (Ej: 5 > 3)
        -- std_logic_vector(to_unsigned(numero, bits)) convierte decimal a binario
        tb_A <= std_logic_vector(to_unsigned(5, 4)); -- A = "0101"
        tb_B <= std_logic_vector(to_unsigned(3, 4)); -- B = "0011"
        wait for 20 ns; -- Esperamos 20 nanosegundos para ver el resultado en la gráfica

        -- CASO 2: A es menor que B (Ej: 2 < 12)
        tb_A <= std_logic_vector(to_unsigned(2, 4));  -- A = "0010"
        tb_B <= std_logic_vector(to_unsigned(12, 4)); -- B = "1100"
        wait for 20 ns;

        -- CASO 3: A es igual a B (Ej: 7 = 7)
        tb_A <= std_logic_vector(to_unsigned(7, 4)); -- A = "0111"
        tb_B <= std_logic_vector(to_unsigned(7, 4)); -- B = "0111"
        wait for 20 ns;

        -- CASO 4: PROBANDO LA EXPANSIÓN
        -- Ponemos A y B iguales (Ej: 9 = 9)
        tb_A <= std_logic_vector(to_unsigned(9, 4));
        tb_B <= std_logic_vector(to_unsigned(9, 4));
        -- PERO le decimos a las entradas de expansión que el chip anterior dijo que A era MENOR
        tb_Gt_in <= '0';
        tb_Eq_in <= '0';
        tb_Lt_in <= '1';
        wait for 20 ns;

        -- Fin de la simulación
        wait; 
    end process;

end Simulacion;