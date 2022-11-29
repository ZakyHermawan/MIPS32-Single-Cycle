-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul : 5
-- Percobaan : 1
-- Tanggal : 25 November 2022
-- Rombongan : B
-- Nama (NIM) : Muhammad Zaky Hermawan (13220022)
-- Nama File : MIPS32.vhd
-- Deskripsi : Top Level Design MIPS32

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library altera_mf;
use altera_mf.altera_mf_components.all;

entity MIPS32 is
port(
	clock: in std_logic;
	reset: in std_logic;
	
	-- program counter
	PC_in_t 	: out std_logic_vector(31 downto 0);
	PC_out_t 	: out std_logic_vector(31 downto 0);
	
	-- instruction memory
	addr_imem_t	: out std_logic_vector(7 downto 0);
	instr_imem_t: out std_logic_vector(31 downto 0);
	
	-- control unit
	op_in_t		: out std_logic_vector(5 downto 0);
	funct_in_t	: out std_logic_vector(5 downto 0);
	
	sig_jmp_t		: out std_logic_vector(1 downto 0);
	sig_bne_t		: out std_logic;
	sig_branch_t	: out std_logic;
	sig_memtoreg_t	: out std_logic;
	sig_memread_t	: out std_logic;
	sig_memwrite_t	: out std_logic;
	sig_regdest_t	: out std_logic_vector(1 downto 0);
	sig_regwrite_t	: out std_logic;
	sig_alusrc_t	: out std_logic_vector(1 downto 0);
	sig_aluctrl_t	: out std_logic_vector(1 downto 0);
	
	-- register file
	wr_en_regfile_t		: out std_logic;
	addr_1_regfile_t	: out std_logic_vector (4 downto 0);
	addr_2_regfile_t	: out std_logic_vector (4 downto 0);
	addr_3_regfile_t	: out std_logic_vector (4 downto 0);
	wr_data_3_regfile_t	: out std_logic_vector(31 downto 0);
	rd_data_1_regfile_t	: out std_logic_vector(31 downto 0);
	rd_data_2_regfile_t	: out std_logic_vector(31 downto 0);

	-- sign extender
	D_In_sgn_extender_t	: out std_logic_vector(15 downto 0);
	D_Out_sgn_extender_t: out std_logic_vector(31 downto 0);

	-- alu
	oprnd_1_alu_t	: out std_logic_vector (31 downto 0); -- Data Input 1
	oprnd_2_alu_t	: out std_logic_vector (31 downto 0); -- Data Input 2
	op_sel_alu_t	: out std_logic_vector (1 downto 0); -- Operation Select
	result_alu_t	: out std_logic_vector (31 downto 0); -- Data Output

	-- data memory
	addr_dmemory_t		: out std_logic_vector(7 downto 0);
	write_en_dmemory_t	: out std_logic;
	rd_en_dmemory_t		: out std_logic;
	rd_data_dmemory_t	: out std_logic_vector(7 downto 0);
	wr_data_dmemory_t	: out std_logic_vector(7 downto 0)
);
end MIPS32;

architecture structural of MIPS32 is

	-- signal for muxbranch
	signal D1_muxbranch	: std_logic_vector(31 downto 0);
	signal D2_muxbranch	: std_logic_vector(31 downto 0);
	signal S_muxbranch	: std_logic;
	signal Y_muxbranch	: std_logic_vector(31 downto 0);

	-- signal for muxjump
	signal D1_muxjump	: std_logic_vector(31 downto 0);
	signal D2_muxjump	: std_logic_vector(31 downto 0);
	signal D3_muxjump	: std_logic_vector(31 downto 0);
	signal D4_muxjump	: std_logic_vector(31 downto 0);
	signal S_muxjump	: std_logic_vector(1 downto 0);
	signal Y_muxjump	: std_logic_vector(31 downto 0);

	-- signal for muxreset
	signal D1_muxreset		: std_logic_vector(31 downto 0);
	signal D2_muxreset		: std_logic_vector(31 downto 0);
	signal reset_muxreset	: std_logic;
	signal Y_muxreset		: std_logic_vector(31 downto 0);

	-- signal for pc
	signal PC_in		: std_logic_vector(31 downto 0);
	signal PC_out		: std_logic_vector(31 downto 0);

	-- signal for adderpc
	signal OPRND_1_adderpc	: std_logic_vector(31 downto 0);
	signal OPRND_2_adderpc	: std_logic_vector(31 downto 0);
	signal C_in_adderpc		: std_logic;
	signal result_adderpc	: std_logic_vector(31 downto 0);
	signal C_out_adderpc	: std_logic;

	-- signal for instrMem
	signal ADDR_InstrMem	: std_logic_vector(7 downto 0);
	signal INSTR_InstrMem	: std_logic_vector(31 downto 0);

	-- signal for control_unit
	signal Op_In		: std_logic_vector(5 downto 0);
	signal FUNCT_In		: std_logic_vector(5 downto 0);
	signal Sig_Jmp 		: STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal Sig_Bne 		: STD_LOGIC;
	signal Sig_Branch 	: STD_LOGIC;
	signal Sig_MemtoReg : STD_LOGIC;
	signal Sig_MemRead 	: STD_LOGIC;
	signal Sig_MemWrite : STD_LOGIC;
	signal Sig_RegDest 	: STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal Sig_RegWrite : STD_LOGIC;
	signal Sig_ALUSrc 	: STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal Sig_ALUCtrl 	: STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	-- signal for regfile
	signal clock_regfile	: std_logic;
	signal wr_en_regfile	: std_logic;
	signal addr_1_regfile	: std_logic_vector (4 downto 0);
	signal addr_2_regfile	: std_logic_vector (4 downto 0);
	signal addr_3_regfile	: std_logic_vector (4 downto 0);
	signal wr_data_3_regfile: std_logic_vector(31 downto 0);
	signal rd_data_1_regfile: std_logic_vector(31 downto 0);
	signal rd_data_2_regfile: std_logic_vector(31 downto 0);
	
	-- signal for mux_regdest
	signal D1_mux_regdest: std_logic_vector(4 downto 0);
	signal D2_mux_regdest: std_logic_vector(4 downto 0);
	signal D3_mux_regdest: std_logic_vector(4 downto 0);
	signal D4_mux_regdest: std_logic_vector(4 downto 0);
	signal S_mux_regdest : std_logic_vector(1 downto 0);
	signal Y_mux_regdest : std_logic_vector(4 downto 0);
	
	-- signal for sgn_extender
	signal D_In_sgn_extender	: std_logic_vector(15 downto 0);
	signal D_Out_sgn_extender	: std_logic_vector(31 downto 0);
	
	-- signal for lshift26_28
	signal D_In_lshift26_28: std_logic_vector(25 downto 0);
	signal D_Out_lshift26_28: std_logic_vector(27 downto 0);
	
	-- signal for bus_merge
	signal D_In_1_bus_merge	: std_logic_vector(3 downto 0);
	signal D_In_2_bus_merge	: std_logic_vector(27 downto 0);
	signal D_Out_bus_merge	: std_logic_vector(31 downto 0);
	
	-- signal for cmp
	signal D_1_cmp	: std_logic_vector(31 downto 0);
	signal D_2_cmp	: std_logic_vector(31 downto 0);
	signal EQ_cmp	: std_logic;
	
	-- signal for mux_alu
	signal D1_mux_alu	: std_logic_vector (31 downto 0);
	signal D2_mux_alu	: std_logic_vector (31 downto 0);
	signal D3_mux_alu	: std_logic_vector (31 downto 0);
	signal D4_mux_alu	: std_logic_vector (31 downto 0);
	signal S_mux_alu	: std_logic_vector (1 downto 0);
	signal Y_mux_alu	: std_logic_vector (31 downto 0);
	
	-- signal for alu_main
	signal OPRND_1_alu_main	: std_logic_vector(31  downto 0);
	signal OPRND_2_alu_main	: std_logic_vector(31  downto 0);
	signal Op_Sel_alu_main	: std_logic_vector(1 downto 0);
	signal result_alu_main	: std_logic_vector(31 downto 0);
	
	-- signal for lshift32_32
	signal D_In_lshift32_32	: std_logic_vector(31 downto 0);
	signal D_Out_lshift32_32: std_logic_vector(31 downto 0);
	
	-- signal for adder_branch
	signal OPRND_1_adder_branch	: std_logic_vector(31 downto 0);
	signal OPRND_2_adder_branch	: std_logic_vector(31 downto 0);
	signal C_IN_adder_branch	: std_logic;
	signal RESULT_adder_branch	: std_logic_vector(31 downto 0);
	signal C_OUT_adder_branch	: std_logic;
	
	-- signal for dmemory
	signal addr_dmemory		: std_logic_vector(7 downto 0);
	signal write_en_dmemory	: std_logic;
	signal rd_en_dmemory	: std_logic;
	signal clock_dmemory	: std_logic := '1';
	signal rd_data_dmemory	: std_logic_vector(7 downto 0);
	signal wr_data_dmemory	: std_logic_vector(7 downto 0);
	
	-- signal for mux_dmemory
	signal D1_mux_dmemory	: std_logic_vector(31 downto 0);
	signal D2_mux_dmemory	: std_logic_vector(31 downto 0);
	signal S_mux_dmemory	: std_logic;
	signal Y_mux_dmemory	: std_logic_vector(31 downto 0);
		
	component mux_2to1_32bit
	port (
		D1	: in std_logic_vector(31 downto 0);
		D2	: in std_logic_vector(31 downto 0);
		S	: 	in std_logic;
		Y	: 	out std_logic_vector(31 downto 0)
	);
	end component;
	
	component mux_4to1_5bit
	port(
		D1	: in std_logic_vector(4 downto 0);
		D2	: in std_logic_vector(4 downto 0);
		D3	: in std_logic_vector(4 downto 0);
		D4	: in std_logic_vector(4 downto 0);
		S	: 	in std_logic_vector(1 downto 0);
		Y	: 	out std_logic_vector(4 downto 0)
	);
	end component;

	component mux_4to1_32bit
	port(
		D1	: in std_logic_vector(31 downto 0);
		D2	: in std_logic_vector(31 downto 0);
		D3	: in std_logic_vector(31 downto 0);
		D4	: in std_logic_vector(31 downto 0);
		S	: 	in std_logic_vector(1 downto 0);
		Y	: 	out std_logic_vector(31 downto 0)
	);
	end component;
		
	component program_counter
	port(
		clk 	: IN STD_LOGIC;
		PC_in 	: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		PC_out 	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	
	component cla_32
	port(
		OPRND_1	: in  std_logic_vector(31 downto 0);
		OPRND_2	: in  std_logic_vector(31 downto 0);
		C_IN 	: in  std_logic;
		RESULT	: out std_logic_vector(31 downto 0);
		C_OUT	: out std_logic
	);
	end component;
	
	component instruction_memory
	port(
		ADDR  : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- alamat
		clock : IN STD_LOGIC := '1'; -- clock
		INSTR : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- output
	);
	end component;
	
	component ALU
	port(
		OPRND_1 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1
		OPRND_2 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
		OP_SEL 	: IN std_logic_vector (1 DOWNTO 0); -- Operation Select
		RESULT 	: OUT std_logic_vector (31 DOWNTO 0) -- Data Output
	);
	end component;

	component cu
	port(
		OP_In 		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		FUNCT_In 	: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		Sig_Jmp 	: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_Bne 	: OUT STD_LOGIC;
		Sig_Branch 	: OUT STD_LOGIC;
		Sig_MemtoReg: OUT STD_LOGIC;
		Sig_MemRead : OUT STD_LOGIC;
		Sig_MemWrite: OUT STD_LOGIC;
		Sig_RegDest : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_RegWrite: OUT STD_LOGIC;
		Sig_ALUSrc 	: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_ALUCtrl : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
	end component;
	
	component reg_file
	port(
		clock		: in std_logic;
		wr_en		: in std_logic;
		addr_1		: in std_logic_vector (4 downto 0);
		addr_2		: in std_logic_vector (4 downto 0);
		addr_3		: in std_logic_vector (4 downto 0);
		wr_data_3	: in std_logic_vector(31 downto 0);
		rd_data_1	: out std_logic_vector(31 downto 0);
		rd_data_2	: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component sign_extender
	port(
		D_In 	:IN std_logic_vector (15 DOWNTO 0); -- Data Input 1 
		D_Out 	:OUT std_logic_vector (31 DOWNTO 0) -- Data Input 2
	);
	end component;
	
	component bus_merger
	port(
		DATA_IN1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		DATA_IN2 : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
		DATA_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	
	-- double left shifter 26 to 28
	component lshift_26_28
	port(
		D_IN 	: IN STD_LOGIC_VECTOR (25 DOWNTO 0); -- Input 26-bit;
		D_OUT 	: OUT STD_LOGIC_VECTOR (27 DOWNTO 0) -- Output 28-bit;
	);
	end component;
	
	-- double left shifter 32 to 32
	component lshift_32_32
	port(
		D_IN 	: IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Input 32-bit;
		D_OUT 	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- Output 32-bit;
	);
	end component;
	
	component comparator
	port(
		D1 : in std_logic_vector (31 DOWNTO 0);
		D2 : in std_logic_vector (31 DOWNTO 0);
		EQ : out std_logic
	);
	end component;
	
	component data_memory
	port(
		addr	: in std_logic_vector(7 downto 0);
		write_en: in std_logic;
		rd_en	: in std_logic;
		clock	: in std_logic := '1';
		rd_data	: out std_logic_vector(7 downto 0);
		wr_data	: in std_logic_vector(7 downto 0)
	);
	end component;
	
begin
	D1_muxbranch <= result_adderpc;
	D2_muxbranch <= result_adder_branch;
	S_muxbranch <= ((not EQ_cmp) and Sig_Bne) or (EQ_cmp and Sig_Branch);
	muxbranch: mux_2to1_32bit port map(
		D1 	=> D1_muxbranch,
		D2 	=> D2_muxbranch,
		S 	=> S_muxbranch,
		Y 	=> Y_muxbranch
	);

	D1_muxjump <= Y_muxbranch;
	D2_muxjump <= D_Out_bus_merge;
	D3_muxjump 	<= (others => '0');
	D4_muxjump 	<= (others => '0');
	S_muxjump 	<= Sig_Jmp;
	muxjump: mux_4to1_32bit port map(
		D1 	=> D1_muxjump,
		D2 	=> D2_muxjump,
		D3 	=> D3_muxjump,
		D4 	=> D4_muxjump,
		S 	=> S_muxjump,
		Y 	=> Y_muxjump
	);

	D1_muxreset 	<= Y_muxjump;
	D2_muxreset 	<= (others => '0');
	reset_muxreset 	<= reset;
	muxreset: mux_2to1_32bit port map(
		D1 	=> D1_muxreset,
		D2 	=> D2_muxreset,
		S 	=> reset_muxreset,
		Y 	=> Y_muxreset
	);
	
	PC_in <= Y_muxreset;
	pc: program_counter port map(
		clk 	=> clock,
		PC_in 	=> PC_in,
		PC_out 	=> PC_out
	);
	
	OPRND_1_adderpc <= PC_out;
	OPRND_2_adderpc <= x"00000004";
	C_in_adderpc 	<= '0';
	adderpc: cla_32 port map(
		OPRND_1	=> OPRND_1_adderpc,
		OPRND_2	=> OPRND_2_adderpc,
		C_IN	=> C_in_adderpc,
		RESULT	=> result_adderpc,
		C_OUT	=> C_out_adderpc
	);

	ADDR_InstrMem <= PC_out(7 downto 0); -- shrink to 8 bit because the address size of instruction memory is 8 bit
	instrMem: instruction_memory port map(
		clock	=> clock,
		ADDR	=> ADDR_InstrMem,
		INSTR	=> INSTR_InstrMem
	);

	Op_In 		<= INSTR_InstrMem(31 downto 26);
	FUNCT_In 	<= INSTR_InstrMem(5 downto 0);
	control_unit : cu port map (
		OP_In 			=> Op_In,
		FUNCT_In 		=> FUNCT_In,
		Sig_Jmp 		=> Sig_Jmp,
		Sig_Bne 		=> Sig_Bne,
		Sig_Branch 		=> Sig_Branch,
		Sig_MemtoReg 	=> Sig_MemtoReg,
		Sig_MemRead 	=> Sig_MemRead,
		Sig_MemWrite 	=> Sig_MemWrite,
		Sig_RegDest 	=> Sig_RegDest,
		Sig_RegWrite 	=> Sig_RegWrite,
		Sig_ALUSrc 		=> Sig_ALUSrc,
		Sig_ALUCtrl 	=> Sig_ALUCtrl
	);
	
	wr_en_regfile 		<= Sig_RegWrite;
	addr_1_regfile 		<= INSTR_InstrMem(25 downto 21);
	addr_2_regfile 		<= INSTR_InstrMem(20 downto 16);
	addr_3_regfile 		<= Y_mux_regdest;
	wr_data_3_regfile 	<= Y_mux_dmemory;
	regfile: reg_file port map(
		clock 		=> clock,
		wr_en 		=> wr_en_regfile,
		addr_1		=> addr_1_regfile,
		addr_2		=> addr_2_regfile,
		addr_3		=> addr_3_regfile,
		wr_data_3 	=> wr_data_3_regfile,
		rd_data_1 	=> rd_data_1_regfile,
		rd_data_2 	=> rd_data_2_regfile
	);
	
	D1_mux_regdest 	<= Instr_InstrMem(20 downto 16);
	D2_mux_regdest 	<= Instr_InstrMem(15 downto 11);
	D3_mux_regdest	<= (others => '0');
	D4_mux_regdest 	<= (others => '0');
	S_mux_regdest 	<= Sig_RegDest;
	mux_regdest: mux_4to1_5bit port map(
		D1 	=> D1_mux_regdest,
		D2 	=> D2_mux_regdest,
		D3 	=> D3_mux_regdest,
		D4 	=> D4_mux_regdest,
		S 	=> S_mux_regdest,
		Y 	=> Y_mux_regdest
	);
	
	D_in_sgn_extender <= Instr_InstrMem(15 downto 0);
	sgn_extender: sign_extender port map(
		D_In 	=> D_In_sgn_extender,
		D_Out 	=> D_Out_sgn_extender
	);
	
	D_In_lshift26_28 <= Instr_InstrMem(25 downto 0);
	lshift26_28: lshift_26_28 port map(
		D_In => D_In_lshift26_28,
		D_Out => D_Out_lshift26_28
	);
	
	D_In_1_bus_merge <= result_adderpc(31 downto 28);
	D_In_2_bus_merge <= D_Out_lshift26_28;
	bus_merge: bus_merger port map(
		DATA_IN1 => D_In_1_bus_merge,
		DATA_IN2 => D_In_2_bus_merge,
		DATA_OUT => D_Out_bus_merge
	);
	
	D_1_cmp <= rd_data_1_regfile;
	D_2_cmp <= rd_data_2_regfile;
	cmp: comparator port map(
		D1 => D_1_cmp,
		D2 => D_2_cmp,
		EQ => EQ_cmp
	);

	D1_mux_alu 	<= rd_data_2_regfile;
	D2_mux_alu 	<= D_Out_sgn_extender;
	D3_mux_alu 	<= (others => '0');
	D4_mux_alu 	<= (others => '0');
	S_mux_alu 	<= Sig_ALUSrc;
	mux_alu: mux_4to1_32bit port map(
		D1 => D1_mux_alu,
		D2 => D2_mux_alu,
		D3 => D3_mux_alu,
		D4 => D4_mux_alu,
		S => S_mux_alu,
		Y => Y_mux_alu
	);
	
	OPRND_1_alu_main 	<= rd_data_1_regfile;
	OPRND_2_alu_main 	<= Y_mux_alu;
	Op_Sel_alu_main		<= Sig_ALUCtrl;
	alu_main: ALU port map (
		OPRND_1 => OPRND_1_alu_main,
		OPRND_2 => OPRND_2_alu_main,
		OP_SEL => Op_Sel_alu_main,
		RESULT => result_alu_main
	);
	
	D_In_lshift32_32 <= D_Out_sgn_extender;
	lshift32_32: lshift_32_32 port map(
		D_In 	=> D_In_lshift32_32,
		D_Out 	=> D_Out_lshift32_32
	);
	
	OPRND_1_adder_branch 	<= D_Out_lshift32_32;
	OPRND_2_adder_branch 	<= result_adderpc;
	C_IN_adder_branch 		<= '0';
	adder_branch: cla_32 port map(
		OPRND_1	=> OPRND_1_adder_branch,
		OPRND_2	=> OPRND_2_adder_branch,
		C_IN 	=> C_IN_adder_branch,
		RESULT	=> RESULT_adder_branch,
		C_OUT	=> C_OUT_adder_branch
	);
	
	addr_dmemory 		<= result_alu_main(7 downto 0); -- shrink to 8 bit because the address size of data memory is 8 bit
	write_en_dmemory	<= Sig_MemWrite;
	rd_en_dmemory 		<= Sig_MemRead;
	wr_data_dmemory 	<= rd_data_2_regfile(7 downto 0); -- shrink to 8 bit because the data size of data memory is 8 bit
	dmemory: data_memory port map(
		addr 	=> addr_dmemory,
		write_en=> write_en_dmemory,
		rd_en 	=> rd_en_dmemory,
		clock 	=> clock,
		rd_data => rd_data_dmemory,
		wr_data => wr_data_dmemory
	);
	
	D1_mux_dmemory 	<= result_alu_main;
	-- extended to 32 bit because data from dmemory is 8 bit, but mux need to accept data in 32 bit
	D2_mux_dmemory 	<= X"000000" & rd_data_dmemory;
	S_mux_dmemory 	<= Sig_MemtoReg;
	mux_dmemory: mux_2to1_32bit port map(
		D1 	=> D1_mux_dmemory,
		D2 	=> D2_mux_dmemory,
		S 	=> S_mux_dmemory,
		Y 	=> Y_mux_dmemory
	);

	-- forward signal to top level design
	PC_in_t 	<= PC_in;
	PC_out_t 	<= PC_out;
	
	-- instruction memory
	addr_imem_t	<= ADDR_InstrMem;
	instr_imem_t<= INSTR_InstrMem;
	
	-- control unit
	op_in_t		<= OP_In;
	funct_in_t	<= FUNCT_In;
	
	sig_jmp_t		<= Sig_Jmp;
	sig_bne_t		<= Sig_Bne;
	sig_branch_t	<= Sig_Branch;
	sig_memtoreg_t	<= Sig_MemtoReg;
	sig_memread_t	<= Sig_MemRead;
	sig_memwrite_t	<= Sig_MemWrite;
	sig_regdest_t	<= Sig_RegDest;
	sig_regwrite_t	<= Sig_RegWrite;
	sig_alusrc_t	<= Sig_ALUSrc;
	sig_aluctrl_t	<= Sig_ALUCtrl;
	
	-- register file
	wr_en_regfile_t		<= wr_en_regfile;
	addr_1_regfile_t	<= addr_1_regfile;
	addr_2_regfile_t	<= addr_2_regfile;
	addr_3_regfile_t	<= addr_3_regfile;
	wr_data_3_regfile_t	<= wr_data_3_regfile;
	rd_data_1_regfile_t	<= rd_data_1_regfile;
	rd_data_2_regfile_t	<= rd_data_2_regfile;

	-- sign extender
	D_In_sgn_extender_t	<= D_in_sgn_extender;
	D_Out_sgn_extender_t<= D_Out_sgn_extender;

	-- alu
	oprnd_1_alu_t	<= OPRND_1_alu_main;
	oprnd_2_alu_t	<= OPRND_2_alu_main;
	op_sel_alu_t	<= OP_SEL_alu_main;
	result_alu_t	<= RESULT_alu_main;

	-- data memory
	addr_dmemory_t		<= addr_dmemory;
	write_en_dmemory_t	<= write_en_dmemory;
	rd_en_dmemory_t		<= rd_en_dmemory;
	rd_data_dmemory_t	<= rd_data_dmemory;
	wr_data_dmemory_t	<= wr_data_dmemory;

end structural;
