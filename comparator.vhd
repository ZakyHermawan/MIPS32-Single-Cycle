library ieee;
use ieee.std_logic_1164.all;

entity comparator is
	port(
		D1 : in std_logic_vector (31 DOWNTO 0);
		D2 : in std_logic_vector (31 DOWNTO 0);
		EQ : out std_logic
	);
end comparator;

architecture behavioral of comparator is
begin
	process(D1, D2)
	begin
		if D1 = D2 then
			EQ <= '1';
		else
			EQ <= '0';
		end if;
	end process;
end behavioral;
