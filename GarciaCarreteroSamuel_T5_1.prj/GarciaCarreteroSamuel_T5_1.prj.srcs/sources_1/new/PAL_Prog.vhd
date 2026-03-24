library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_pal_4l2 is
end tb_pal_4l2;

architecture Behavioral of tb_pal_4l2 is
    signal I0      : STD_LOGIC := '0';
    signal I1      : STD_LOGIC := '0';
    signal I2      : STD_LOGIC := '0';
    signal io0_line: STD_LOGIC := '0';
    signal io0_drv : STD_LOGIC := '0';
    signal S0      : STD_LOGIC;
begin
    -- Driver externo del pin inout (para usar IO0 como entrada)
    io0_line <= io0_drv;

    uut: entity work.PAL_4L2
        port map (
            I0  => I0,
            I1  => I1,
            I2  => I2,
            IO0 => io0_line,
            S0  => S0
        );

    stim_proc: process
        variable expected_s0 : STD_LOGIC;
    begin
        -- Recorre todas las combinaciones de entrada
        for b_io0 in 0 to 1 loop
            if b_io0 = 0 then
                io0_drv <= '0';
            else
                io0_drv <= '1';
            end if;

            for b2 in 0 to 1 loop
                if b2 = 0 then
                    I2 <= '0';
                else
                    I2 <= '1';
                end if;

                for b1 in 0 to 1 loop
                    if b1 = 0 then
                        I1 <= '0';
                    else
                        I1 <= '1';
                    end if;

                    for b0 in 0 to 1 loop
                        if b0 = 0 then
                            I0 <= '0';
                        else
                            I0 <= '1';
                        end if;

                        wait for 10 ns;

                        -- PAL programada como MUX 2:1: S0 = (not I0 and I1) or (I0 and IO0)
                        if I0 = '0' then
                            expected_s0 := I1;
                        else
                            expected_s0 := io0_drv;
                        end if;

                        assert (S0 = expected_s0)
                            report "Fallo en S0 (MUX 2:1) para la combinacion aplicada"
                            severity error;

                        -- IO0 se deja en alta impedancia desde la PAL
                        assert (io0_line = io0_drv)
                            report "Fallo en IO0 (esperado tri-state del DUT)"
                            severity error;
                    end loop;
                end loop;
            end loop;
        end loop;

        assert false report "tb_pal_4l2 completado correctamente" severity note;
        wait;
    end process;

end Behavioral;
