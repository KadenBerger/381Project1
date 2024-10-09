-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- fulladder.vhd
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


entity fulladder is
	port(i_A : in std_logic;
	     i_B : in std_logic;
	     i_C : in std_logic;
             o_S : out std_logic;
	     o_C : out std_logic);
end fulladder;

architecture structural of fulladder is

component invg
	port(i_A : in std_logic;
	     o_F : out std_logic);
end component;

component andg2 is
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component org2 is
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component xorg2 is
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

signal AxorB, AxorBxorC, AandB, AxorBandCin, BandCin, AandCin, AandBorBandCin: std_logic;

begin

xor1: xorg2 port map(i_A => i_A,
       		     i_B => i_B,
       		     o_F => AxorB);

xor2: xorg2 port map(i_A => AxorB,
       		     i_B => i_C,
       		     o_F => o_S);

and1: andg2 port map (i_A => i_A,
	   	      i_B => i_B,
		      o_F => AandB);

and2: andg2 port map (i_A => i_C,
	   	      i_B => i_B,
		      o_F => BandCin);

and3: andg2 port map (i_A => i_C,
	   	      i_B => i_A,
		      o_F => AandCin);

or1: org2 port map (i_A => AandB,
		      i_B => BandCin,
		      o_F => AandBorBandCin);

or2: org2 port map (i_A => AandBorBandCin,
		      i_B => AandCin,
		      o_F => o_C);

end architecture structural;