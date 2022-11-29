library ieee;
use ieee.std_logic_1164.all;
LIBRARY altera_mf;
USE altera_mf.all;

entity data_memory is
	port(
		addr: in std_logic_vector(7 downto 0);
		write_en: in std_logic;
		rd_en: in std_logic;
		clock: in std_logic := '1';
		rd_data: out std_logic_vector(7 downto 0);
		wr_data: in std_logic_vector(7 downto 0)
	);
end entity;

architecture structural of data_memory is
component altsyncram
generic
(
	init_file: string;
	operation_mode: string;
	widthad_a: natural;
	width_a: natural
);
port(
	wren_a: in std_logic;
	rden_a: in std_logic;
	clock0: in std_logic;
	address_a: in std_logic_vector(7 downto 0);
	q_a: out std_logic_vector(7 downto 0);
	data_a: in std_logic_vector(7 downto 0)
);
end component;

begin
altsyncram_component: altsyncram
generic map
(
	init_file => "dmemory.mif",
	operation_mode => "SINGLE_PORT",
	widthad_a => 8,
	width_a => 8
)

port map
(
	wren_a => write_en,
	rden_a => rd_en,
	clock0 => clock,
	address_a => addr,
	q_a => rd_data,
	data_a => wr_data
);
end structural;
