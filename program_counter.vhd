LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY program_counter IS
	PORT (
			clk : IN STD_LOGIC;
			PC_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			PC_out : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
END program_counter;

ARCHITECTURE structural OF program_counter IS
	component DFLIPFLOP
		port(
			clk: in std_logic;
			D: in std_logic;
			Q: out std_logic
		);
	end component DFLIPFLOP;
	
BEGIN

        DFF0:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(0),
                Q => PC_out(0)
        );
        
		DFF1:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(1),
                Q => PC_out(1)
        );

        DFF2:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(2),
                Q => PC_out(2)
        );

        DFF3:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(3),
                Q => PC_out(3)
        );

        DFF4:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(4),
                Q => PC_out(4)
        );

        DFF5:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(5),
                Q => PC_out(5)
        );

        DFF6:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(6),
                Q => PC_out(6)
        );

        DFF7:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(7),
                Q => PC_out(7)
        );

        DFF8:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(8),
                Q => PC_out(8)
        );

        DFF9:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(9),
                Q => PC_out(9)
        );

        DFF10:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(10),
                Q => PC_out(10)
        );

        DFF11:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(11),
                Q => PC_out(11)
        );

        DFF12:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(12),
                Q => PC_out(12)
        );

        DFF13:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(13),
                Q => PC_out(13)
        );

        DFF14:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(14),
                Q => PC_out(14)
        );

        DFF15:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(15),
                Q => PC_out(15)
        );

        DFF16:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(16),
                Q => PC_out(16)
        );

        DFF17:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(17),
                Q => PC_out(17)
        );

        DFF18:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(18),
                Q => PC_out(18)
        );

        DFF19:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(19),
                Q => PC_out(19)
        );

        DFF20:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(20),
                Q => PC_out(20)
        );

        DFF21:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(21),
                Q => PC_out(21)
        );

        DFF22:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(22),
                Q => PC_out(22)
        );

        DFF23:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(23),
                Q => PC_out(23)
        );

        DFF24:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(24),
                Q => PC_out(24)
        );

        DFF25:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(25),
                Q => PC_out(25)
        );

        DFF26:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(26),
                Q => PC_out(26)
        );

        DFF27:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(27),
                Q => PC_out(27)
        );

        DFF28:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(28),
                Q => PC_out(28)
        );

        DFF29:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(29),
                Q => PC_out(29)
        );

        DFF30:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(30),
                Q => PC_out(30)
        );

        DFF31:DFLIPFLOP
        PORT MAP
        (
                clk => clk,
                D => PC_in(31),
                Q => PC_out(31)
        );

END structural;
