-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_dataflow.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/9/24:Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity
entity mux2t1_dataflow is
	port(i_S	: in std_logic;
	i_D0		: in std_logic;
	i_D1		: in std_logic;
	o_O		: out std_logic);
end mux2t1_dataflow;

--architecture
architecture mux2t1 of mux2t1_dataflow is

begin

	 o_O <= i_D0 when (i_S = '0') else
		i_D1 when (i_S = '1') else
		'0';
end mux2t1;
	
	