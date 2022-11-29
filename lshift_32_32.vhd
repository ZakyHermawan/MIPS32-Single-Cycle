LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY lshift_32_32 IS
	PORT (
			D_IN : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Input 32-bit;
			D_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- Output 32-bit;
		);
END lshift_32_32;

ARCHITECTURE Behavioral OF lshift_32_32 IS
    BEGIN
        PROCESS (D_IN)
            BEGIN
                D_OUT <= D_IN(29 DOWNTO 0) & "00";
        END PROCESS;
END Behavioral;
