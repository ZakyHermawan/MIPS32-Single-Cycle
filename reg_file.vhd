library ieee;
library altera_mf;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is
	port(
		clock: in std_logic;
		wr_en: in std_logic;
		addr_1: in std_logic_vector (4 downto 0);
		addr_2: in std_logic_vector (4 downto 0);
		addr_3: in std_logic_vector (4 downto 0);
		wr_data_3: in std_logic_vector(31 downto 0);
		rd_data_1: out std_logic_vector(31 downto 0);
		rd_data_2: out std_logic_vector(31 downto 0)
	);
end entity;


architecture behavioral of reg_file is
	type ramtype is array (31 downto 0) of std_logic_vector(31 downto 0);
	signal mem: ramtype;
begin
	process (clock)
	begin
		if clock'event and clock = '0' and wr_en = '0' then
			rd_data_1 <= mem(to_integer(unsigned(addr_1)));
			rd_data_2 <= mem(to_integer(unsigned(addr_2)));
		elsif clock'event and clock= '1' and wr_en = '1' then
			mem(to_integer(unsigned(addr_3))) <= wr_data_3;
		end if;
	end process;
end behavioral;
