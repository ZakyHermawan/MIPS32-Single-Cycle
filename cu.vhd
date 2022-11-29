library ieee;
use ieee.std_logic_1164.all;

entity cu is
	port(
		OP_In : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		FUNCT_In : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		Sig_Jmp : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_Bne : OUT STD_LOGIC;
		Sig_Branch : OUT STD_LOGIC;
		Sig_MemtoReg : OUT STD_LOGIC;
		Sig_MemRead : OUT STD_LOGIC;
		Sig_MemWrite : OUT STD_LOGIC;
		Sig_RegDest : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_RegWrite : OUT STD_LOGIC;
		Sig_ALUSrc : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_ALUCtrl : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
end cu;

architecture behavioral of cu is
begin

process(OP_In, FUNCT_In)
begin
	if (Op_In = "000000") then
		if (FUNCT_In = "100000") then
			-- add
			Sig_Jmp <= "00";
			Sig_Bne <= '0';
			Sig_Branch <= '0';
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegDest <= "01";
			Sig_RegWrite <= '1';
			Sig_ALUSrc <= "00";
			Sig_ALUCtrl <= "00";
		elsif (FUNCT_In = "100010") then
			-- sub
			Sig_Jmp <= "00";
			Sig_Bne <= '0';
			Sig_Branch <= '0';
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegDest <= "01";
			Sig_RegWrite <= '1';
			Sig_ALUSrc <= "00";
			Sig_ALUCtrl <= "01";
		elsif (FUNCT_In = "000000") then
			-- nop
			Sig_Jmp <= "00";
			Sig_Bne <= '0';
			Sig_Branch <= '0';
			Sig_MemtoReg <= '0';
			Sig_MemRead <= '0';
			Sig_MemWrite <= '0';
			Sig_RegDest <= "00";
			Sig_RegWrite <= '0';
			Sig_ALUSrc <= "00";
			Sig_ALUCtrl <= "00";
		end if;
	elsif (Op_In = "000100") then
		-- beq
		Sig_Jmp <= "00";
		Sig_Bne <= '0';
		Sig_Branch <= '1';
		Sig_MemtoReg <= '0';
		Sig_MemRead <= '0';
		Sig_MemWrite <= '0';
		Sig_RegDest <= "--";
		Sig_RegWrite <= '0';
		Sig_ALUSrc <= "--";
		Sig_ALUCtrl <= "--";
	elsif (Op_In = "000101") then
		-- bne
		Sig_Jmp <= "00";
		Sig_Bne <= '1';
		Sig_Branch <= '0';
		Sig_MemtoReg <= '0';
		Sig_MemRead <= '0';
		Sig_MemWrite <= '0';
		Sig_RegDest <= "--";
		Sig_RegWrite <= '0';
		Sig_ALUSrc <= "--";
		Sig_ALUCtrl <= "--";
	elsif (Op_In = "001000") then
		-- addi
		Sig_Jmp <= "00";
		Sig_Bne <= '0';
		Sig_Branch <= '0';
		Sig_MemtoReg <= '0';
		Sig_MemRead <= '0';
		Sig_MemWrite <= '0';
		Sig_RegDest <= "00";
		Sig_RegWrite <= '1';
		Sig_ALUSrc <= "01";
		Sig_ALUCtrl <= "00";
	elsif (Op_In = "100011") then
		-- lw
		Sig_Jmp <= "00";
		Sig_Bne <= '0';
		Sig_Branch <= '0';
		Sig_MemtoReg <= '1';
		Sig_MemRead <= '1';
		Sig_MemWrite <= '0';
		Sig_RegDest <= "00";
		Sig_RegWrite <= '1';
		Sig_ALUSrc <= "01";
		Sig_ALUCtrl <= "00";
	elsif (Op_In = "101011") then
		-- sw
		Sig_Jmp <= "00";
		Sig_Bne <= '0';
		Sig_Branch <= '0';
		Sig_MemtoReg <= '0';
		Sig_MemRead <= '0';
		Sig_MemWrite <= '1';
		Sig_RegDest <= "00";
		Sig_RegWrite <= '0';
		Sig_ALUSrc <= "01";
		Sig_ALUCtrl <= "00";
	elsif (Op_In = "000010") then
		-- jmp
		Sig_Jmp <= "01";
		Sig_Bne <= '0';
		Sig_Branch <= '0';
		Sig_MemtoReg <= '0';
		Sig_MemRead <= '0';
		Sig_MemWrite <= '0';
		Sig_RegDest <= "--";
		Sig_RegWrite <= '0';
		Sig_ALUSrc <= "--";
		Sig_ALUCtrl <= "--";
	end if;
end process;

end behavioral;

