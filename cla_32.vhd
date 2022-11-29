library ieee;
use ieee.std_logic_1164.all;

entity cla_32 is
generic (M : integer := 32);
port (
    OPRND_1	: in  std_logic_vector(M-1 downto 0);
    OPRND_2	: in  std_logic_vector(M-1 downto 0);
    C_IN 	: in  std_logic;
    RESULT	: out std_logic_vector(M-1 downto 0);
    C_OUT	: out std_logic
);
end cla_32;

architecture rtl of cla_32 is
    signal c : std_logic_vector(M downto 0) := (others =>'0');
    signal p, g : std_logic_vector(M-1 downto 0) := (others =>'0');
begin

    p <= OPRND_1 xor OPRND_2;
    g <= OPRND_1 and OPRND_2;
    RESULT <= p xor c(M-1 downto 0);
    C_OUT <= c(M);

    c(0) <= C_IN;
    gen: for i in 0 to M-1 generate
        c(i+1) <= g(i) or (p(i) and c(i));
    end generate;
end rtl;