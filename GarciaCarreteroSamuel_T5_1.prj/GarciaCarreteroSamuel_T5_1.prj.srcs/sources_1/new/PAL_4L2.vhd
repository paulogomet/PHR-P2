----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2026 09:04:08 PM
-- Design Name: 
-- Module Name: AND - Behavioral
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

-- PAL 4L2
-- 1 pin salida
-- 1 pin inout
-- Fusibles ("inventar implementación en VHDL")
-- Fichero texto añadirlo al proyecto (grupo, nº de fusibles)
-- CUIDADO PINES AL AIRE
-- Estilo descripción libre
-- Modulo superior: PAL_4L2
-- Particularizar: (PAL_PROG) MUX 2 canales
-- Todos los componentes implementados probados
-- Mandar proyecto en ZIP

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


-- Creamos el bloque PAL_4L2 (entity) y definimos sus pines de entrada y salida (Port)
entity PAL_4L2 is
    Port ( I0 : in  STD_LOGIC;
           I1 : in  STD_LOGIC;
           I2 : in  STD_LOGIC;
           IO0 : inout  STD_LOGIC;
           S0 : out  STD_LOGIC);
end PAL_4L2;

-- Definimos lo que va a haber dentro del bloque de la PAL
architecture Behavioral of PAL_4L2 is
    -- "type" es una especie de plantilla. Aqui decimos que existe un tipo de dato
    -- llamado and_matrix que es una cuadricula de 8x8 celdas, y en cada celda cabe
    -- un bit logico
    type and_matrix is array (0 to 7, 0 to 7) of STD_LOGIC;

    -- declaramos dos buses (físicos) de 8 y 16 cables
    signal vertical_lines : STD_LOGIC_VECTOR(7 downto 0);
    signal and_outputs : STD_LOGIC_VECTOR(7 downto 0); 


    -- declaramos las matrices de fusibles físicas basandonos en la plantilla de antes
    -- others => '0' sirve para rellenar todas las posiciones con un '0'
    constant AND_FUSES : and_matrix := (
        -- T0: habilitación de salida tri-state de IO0 (0 = siempre alta impedancia)
        0 => (others => '0'),

        -- T1 para S0: (not I0) and I1
        1 => (1 => '1', 2 => '1', others => '0'),

        -- T2 para S0: I0 and IO0
        2 => (0 => '1', 6 => '1', others => '0'),

        -- Términos no usados
        others => (others => '0')
    );

    A¬S or BS
    

begin
    -- Conectamos las lineas verticales a cada entrada y su negado
    vertical_lines(0) <= I0;
    vertical_lines(1) <= not I0;
    vertical_lines(2) <= I1;
    vertical_lines(3) <= not I1;
    vertical_lines(4) <= I2;
    vertical_lines(5) <= not I2;
    vertical_lines(6) <= IO0;
    vertical_lines(7) <= not IO0;

    -- conectamos las entradas que hayamos especificado a las puertas and
    process(vertical_lines)
        variable temp_and : STD_LOGIC;
        variable has_connection : STD_LOGIC;
    begin  
        
        -- para cada puerta and
        for i in 0 to 7 loop
            temp_and := '1';
            has_connection := '0';

            -- Para cada entrada de una puerta and
            for j in 0 to 7 loop
                
                -- si el fusible es 1, está conectado, entonces hace que temp_and sea el resultado de temp_and AND (la linea vertical que toque)
                if AND_FUSES(i, j) = '1' then
                    temp_and := temp_and AND vertical_lines(j);
                    has_connection := '1';
                end if;
            end loop;
            
            -- Si no hay conexiones, consideramos término no programado => 0
            if has_connection = '1' then
                and_outputs(i) <= temp_and;
            else
                and_outputs(i) <= '0';
            end if;

        end loop;
    end process;

    -- Aqui modelamos la matriz OR
    process(and_outputs)
        variable temp_or_S0 : STD_LOGIC;
        variable temp_or_IO0 : STD_LOGIC;
    begin
        temp_or_S0 := '0';
        temp_or_IO0 := '0';
        
        -- Para cada salida de cada AND
        for i in 1 to 3 loop            
            temp_or_S0 := temp_or_S0 or and_outputs(i);
        end loop;
        
        for i in 4 to 7 loop
            temp_or_IO0 := temp_or_IO0 or and_outputs(i);
        end loop;

        -- La salida de S0 = temp_or_S0
        S0 <= temp_or_S0;

        -- Si el enable del pin IO0 está activo, entonces la salida es lo que se haya calculado en temp_or_IO0, si no, la salida es Z (alta impedancia)
        if and_outputs(0) = '1' then
            IO0 <= temp_or_IO0;
        else
            IO0 <= 'Z';
        end if;

    end process;

end Behavioral;