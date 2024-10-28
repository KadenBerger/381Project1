-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/4/24:Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

-- Entity
entity mux2t1 is
	port(i_S	: in std_logic;
	i_D0		: in std_logic;
	i_D1		: in std_logic;
	o_O		: out std_logic);
end mux2t1;

-- Architecture
architecture ckt1 of mux2t1 is

-- NOT gate -------------------
component invg
	port(i_A          : in std_logic;
	o_F          : out std_logic);
end component;

-- 2-input OR gate -------------------
component org2 

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

-- 2-input AND gate -------------------
component andg2

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

--i ntermediate signal declaration
signal p1_out,p2_out,p3_out : std_logic;

begin
	--o_O <= (i_D0 and not i_S) or (i_D1 and i_S);

	n1: invg port map (i_A => i_S,
			   o_F => p1_out);

	a1: andg2 port map (i_A => i_D0,
			   i_B => p1_out,
			   o_F => p2_out);

	a2: andg2 port map (i_A => i_D1,
			   i_B => i_S,
			   o_F => p3_out);

	a3: org2 port map (i_A => p2_out,
			   i_B => p3_out,
			   o_F => o_O);


end ckt1;