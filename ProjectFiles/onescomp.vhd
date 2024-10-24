-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- onescomp.vhd
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


entity onescomp is
generic(N : integer := 32);
	port(i_N : in std_logic_vector(N-1 downto 0);
	     o_F : out std_logic_vector(N-1 downto 0));
end onescomp;

architecture dataflow of onescomp is

begin

o_F <= not i_N;

end architecture dataflow;