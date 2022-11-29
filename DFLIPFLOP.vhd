library ieee;
use ieee.std_logic_1164.all;

ENTITY DFLIPFLOP IS
	PORT (
			clk : IN STD_LOGIC;
			D : IN STD_LOGIC;
			Q : OUT STD_LOGIC
		);
END DFLIPFLOP;

ARCHITECTURE Behavioral OF DFLIPFLOP IS
    BEGIN
        PROCESS (clk)
			BEGIN
			IF clk'EVENT AND clk = '1' THEN
				Q <= D;
			END IF;
        END PROCESS;
END Behavioral;
