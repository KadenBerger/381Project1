-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- fulladder_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide ripple carry
-- full adder.
-- NOTES:
-- 9/10/24 by Kaden Berger::Created.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;


entity fulladder_N is
generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     i_Cin : in std_logic;
             o_Sum : out std_logic_vector(N-1 downto 0);
	     o_Cout : out std_logic);
end fulladder_N;

architecture structural of fulladder_N is

signal carry : std_logic_vector(N downto 0);

component fulladder is
	port(i_A : in std_logic;
	     i_B : in std_logic;
	     i_C : in std_logic;
             o_S : out std_logic;
	     o_C : out std_logic);
end component;

begin

carry(0) <= i_Cin;

GEN_FULLADDERS: for i in 0 to N-1 generate
FA: fulladder port map(i_A => i_A(i),
		       i_B => i_B(i),
		       i_C => carry(i),
		       o_S => o_Sum(i),
		       o_C => carry(i+1));
end generate;

o_Cout <= carry(N);

end architecture structural;