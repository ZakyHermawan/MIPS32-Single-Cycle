library ieee;
use ieee.std_logic_1164.all;

entity mux_2to1_32bit is
	port(
		D1: in std_logic_vector(31 downto 0);
		D2: in std_logic_vector(31 downto 0);
		S: in std_logic;
		Y: out std_logic_vector(31 downto 0)
	);
end mux_2to1_32bit;

architecture behavioral of mux_2to1_32bit is
begin
	process(D1, D2, S)
	begin
		if S = '0' then
			Y <= D1;
		else
			Y <= D2;
		end if;
	end process;
end;
