LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY lshift_26_28 IS
	PORT (
			D_IN : IN STD_LOGIC_VECTOR (25 DOWNTO 0); -- Input 26-bit;
			D_OUT : OUT STD_LOGIC_VECTOR (27 DOWNTO 0) -- Output 28-bit;
		);
END lshift_26_28;

ARCHITECTURE Behavioral OF lshift_26_28 IS
    BEGIN
        PROCESS (D_IN)
            BEGIN
                D_OUT <= D_IN & "00";
        END PROCESS;
END Behavioral;
