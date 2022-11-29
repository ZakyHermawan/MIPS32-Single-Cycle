library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1_5bit is
	port(
		D1: in std_logic_vector(4 downto 0);
		D2: in std_logic_vector(4 downto 0);
		D3: in std_logic_vector(4 downto 0);
		D4: in std_logic_vector(4 downto 0);
		S: in std_logic_vector(1 downto 0);
		Y: out std_logic_vector(4 downto 0)
	);
end mux_4to1_5bit;

architecture behavioral of mux_4to1_5bit is
begin
	process(D1, D2, D3, D4, S)
	begin
		case S is
			when "00" => Y <= D1;
			when "01" => Y <= D2;
			when "10" => Y <= D3;
			when "11" => Y <= D4;
			when others =>
		end case;
	end process;
end;
