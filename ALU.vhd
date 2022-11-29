library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	PORT(
		OPRND_1 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1
		OPRND_2 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
		OP_SEL : IN std_logic_vector (1 DOWNTO 0); -- Operation Select
		RESULT : OUT std_logic_vector (31 DOWNTO 0) -- Data Output
	);
end ALU;

architecture behavioral of ALU is
	component cla_32 is
	port (
		OPRND_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operand 1
		OPRND_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Operand 2
		C_IN : IN STD_LOGIC;
		RESULT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- Result
		C_OUT : OUT STD_LOGIC
	);
	end component;
	
	signal adder_op1: std_logic_vector(31 DOWNTO 0);
	signal adder_op2: std_logic_vector(31 DOWNTO 0);
	signal adder_res: std_logic_vector(31 DOWNTO 0);
	signal adder_cin: std_logic;
	signal adder_cout: std_logic;

	signal substractor_op1: std_logic_vector(31 DOWNTO 0);
	signal substractor_op2: std_logic_vector(31 DOWNTO 0);
	signal substractor_res: std_logic_vector(31 DOWNTO 0);
	signal substractor_cin: std_logic;
	signal substractor_cout: std_logic;

begin
	adder: cla_32
	PORT MAP (
		OPRND_1 => adder_op1,
		OPRND_2 => adder_op2,
		C_IN => '0',
		C_OUT => adder_cout,
		RESULT => adder_res
	);
	
	substractor: cla_32
	PORT MAP(
		OPRND_1 => substractor_op1,
		OPRND_2 => substractor_op2,
		C_IN => '1',
		C_OUT => substractor_cout,
		RESULT => substractor_res
	);
	
	process (OPRND_1, OPRND_2, OP_SEL)
	begin
		if (OP_SEL = "00") then
			adder_op1 <= OPRND_1;
			adder_op2 <= OPRND_2;
			RESULT <= adder_res;
		elsif (OP_SEL = "01") then
			substractor_op1 <= OPRND_1;
			substractor_op2 <= not OPRND_2;
			RESULT <= substractor_res;
		end if;
	end process;
end behavioral;
