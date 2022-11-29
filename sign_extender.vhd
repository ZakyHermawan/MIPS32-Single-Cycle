LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sign_extender IS
	PORT (
		D_In :IN std_logic_vector (15 DOWNTO 0); -- Data Input 1 
		D_Out :OUT std_logic_vector (31 DOWNTO 0) -- Data Input 2
	);
END sign_extender;

ARCHITECTURE Behavioral OF sign_extender IS
    BEGIN
        PROCESS (D_In)
            BEGIN
            IF D_In(15) = '0' THEN
				D_Out <= X"0000" & D_In;
			ELSE
				D_Out <= X"FFFF" & D_In;
			END IF;
        END PROCESS;
END Behavioral;
