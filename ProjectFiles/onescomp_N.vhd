-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- onescomp_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/10/24 by Kaden Berger::Created.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;


entity onescomp_N is
generic(N : integer := 32);
	port(i_N : in std_logic_vector(N-1 downto 0);
	     o_F : out std_logic_vector(N-1 downto 0));
end onescomp_N;

architecture structural of onescomp_N is

component invg

	port(i_A : in std_logic;
	     o_F : out std_logic);
end component;

signal s_N : std_logic_vector(N-1 downto 0);

begin

 G_NBit_ONESCOMP: for i in 0 to N-1 generate
	invg_inst: invg
	port map(i_A => i_N(i),
		 o_F => s_N(i));
end generate;

o_F <= s_N;

end architecture structural;
		

