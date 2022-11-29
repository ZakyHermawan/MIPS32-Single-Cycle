library ieee;
use ieee.std_logic_1164.all;

entity bus_merger is
	port(
		DATA_IN1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		DATA_IN2 : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
		DATA_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end bus_merger;

architecture behavioral of bus_merger is
begin
process(DATA_IN1, DATA_IN2)
begin
	DATA_OUT <= DATA_IN1 & DATA_IN2;
end process;
end behavioral;

