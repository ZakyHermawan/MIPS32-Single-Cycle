-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 5
-- Percobaan : 1
-- Tanggal : 25 November 2022
-- Rombongan : B
-- Nama (NIM) : Muhammad Zaky Hermawan (13220022)
-- Nama File : testbench.vhd
-- Deskripsi : testbench

library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture tb of testbench is
	signal clock: std_logic := '0';
	signal reset: std_logic := '1';
	
	-- program counter
	signal PC_in_t 	: std_logic_vector(31 downto 0);
	signal PC_out_t 	: std_logic_vector(31 downto 0);
	
	-- instruction memory
	signal addr_imem_t	: std_logic_vector(7 downto 0);
	signal instr_imem_t: std_logic_vector(31 downto 0);
	
	-- control unit
	signal op_in_t		: std_logic_vector(5 downto 0);
	signal funct_in_t	: std_logic_vector(5 downto 0);
	
	signal sig_jmp_t		: std_logic_vector(1 downto 0);
	signal sig_bne_t		: std_logic;
	signal sig_branch_t		: std_logic;
	signal sig_memtoreg_t	: std_logic;
	signal sig_memread_t	: std_logic;
	signal sig_memwrite_t	: std_logic;
	signal sig_regdest_t	: std_logic_vector(1 downto 0);
	signal sig_regwrite_t	: std_logic;
	signal sig_alusrc_t	: std_logic_vector(1 downto 0);
	signal sig_aluctrl_t	: std_logic_vector(1 downto 0);
	
	-- register file
	signal wr_en_regfile_t		: std_logic;
	signal addr_1_regfile_t	: std_logic_vector (4 downto 0);
	signal addr_2_regfile_t	: std_logic_vector (4 downto 0);
	signal addr_3_regfile_t	: std_logic_vector (4 downto 0);
	signal wr_data_3_regfile_t	: std_logic_vector(31 downto 0);
	signal rd_data_1_regfile_t	: std_logic_vector(31 downto 0);
	signal rd_data_2_regfile_t	: std_logic_vector(31 downto 0);

	-- sign extender
	signal D_In_sgn_extender_t	: std_logic_vector(15 downto 0);
	signal D_Out_sgn_extender_t: std_logic_vector(31 downto 0);

	-- alu
	signal oprnd_1_alu_t	: std_logic_vector (31 downto 0); -- Data Input 1
	signal oprnd_2_alu_t	: std_logic_vector (31 downto 0); -- Data Input 2
	signal op_sel_alu_t	: std_logic_vector (1 downto 0); -- Operation Select
	signal result_alu_t	: std_logic_vector (31 downto 0); -- Data Output

	-- data memory
	signal addr_dmemory_t		: std_logic_vector(7 downto 0);
	signal write_en_dmemory_t	: std_logic;
	signal rd_en_dmemory_t		: std_logic;
	signal rd_data_dmemory_t	: std_logic_vector(7 downto 0);
	signal wr_data_dmemory_t	: std_logic_vector(7 downto 0);
begin
	dut: entity work.MIPS32
	port map(
	clock => clock,
	reset => reset,
	
	-- program counter
	PC_in_t 	=> PC_in_t,
	PC_out_t 	=> PC_out_t,
	
	-- instruction memory
	addr_imem_t	=> addr_imem_t,
	instr_imem_t=> instr_imem_t,
	
	-- control unit
	op_in_t		=> op_in_t,
	funct_in_t	=> funct_in_t,
	
	sig_jmp_t		=> sig_jmp_t,
	sig_bne_t		=> sig_bne_t,
	sig_branch_t	=> sig_branch_t,
	sig_memtoreg_t	=> sig_memtoreg_t,
	sig_memread_t	=> sig_memtoreg_t,
	sig_memwrite_t	=> sig_memtoreg_t,
	sig_regdest_t	=> sig_regdest_t,
	sig_regwrite_t	=> sig_regwrite_t,
	sig_alusrc_t	=> sig_alusrc_t,
	sig_aluctrl_t	=> sig_aluctrl_t,
	
	-- register file
	wr_en_regfile_t		=> wr_en_regfile_t,
	addr_1_regfile_t	=> addr_1_regfile_t,
	addr_2_regfile_t	=> addr_2_regfile_t,
	addr_3_regfile_t	=> addr_3_regfile_t,
	wr_data_3_regfile_t	=> wr_data_3_regfile_t,
	rd_data_1_regfile_t	=> rd_data_1_regfile_t,
	rd_data_2_regfile_t	=> rd_data_2_regfile_t,

	-- sign extender
	D_In_sgn_extender_t	=> D_In_sgn_extender_t,
	D_Out_sgn_extender_t => D_Out_sgn_extender_t,

	-- alu
	oprnd_1_alu_t	=> oprnd_1_alu_t,
	oprnd_2_alu_t	=> oprnd_2_alu_t,
	op_sel_alu_t	=> op_sel_alu_t,
	result_alu_t	=> result_alu_t,

	-- data memory
	addr_dmemory_t		=> addr_dmemory_t,
	write_en_dmemory_t	=> write_en_dmemory_t,
	rd_en_dmemory_t		=> rd_en_dmemory_t,
	rd_data_dmemory_t	=> rd_data_dmemory_t,
	wr_data_dmemory_t	=> wr_data_dmemory_t
	);
	
	stimulus1: process
	begin
		clock <= not clock;
		wait for 10ns;
	end process;
	
	stimulus2: process
	begin
		wait for 20 ns;
		reset <= '0';
		wait for 200 ns;
		reset <= '1';
	end process;

end architecture tb;
