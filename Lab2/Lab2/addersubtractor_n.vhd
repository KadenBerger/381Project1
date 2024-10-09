-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- addersubstractor_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide ripple carry
-- adder subtractor.
-- NOTES:
-- 9/26/24 by Kaden Berger::Created.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;


entity addersubtractor_N is
generic(N : integer := 32);
	port(A : in std_logic_vector(N-1 downto 0);
	     B : in std_logic_vector(N-1 downto 0);
	     imm: in std_logic_vector(N-1 downto 0);
	     ALUSrc : in std_logic;
	     nAdd_Sub : in std_logic;
             Sum : out std_logic_vector(N-1 downto 0);
	     Cout : out std_logic);
end addersubtractor_N;

architecture structural of addersubtractor_N is

component fulladder_N is
generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     i_Cin : in std_logic;
             o_Sum : out std_logic_vector(N-1 downto 0);
	     o_Cout : out std_logic);
end component;

component mux2t1_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

component onescomp_N is
generic(N : integer := 32);
	port(i_N : in std_logic_vector(N-1 downto 0);
	     o_F : out std_logic_vector(N-1 downto 0));
end component;

signal notbORimm, muxBOut, bORimm : std_logic_vector(N-1 downto 0);
signal carry : std_logic;

begin
mux: mux2t1_N
	generic map(N => N)
	port map(i_S => ALUSrc,
		 i_D0 => B,
		 i_D1 => imm,
		 o_O => bORimm);

inverter_N: onescomp_N
	generic map(N => N) 
	port map(i_N => bORimm,
		 o_F => notbORimm);

mux2: mux2t1_N
	generic map(N => N)
	port map(i_S => nAdd_Sub,
		 i_D0 => bORimm,
		 i_D1 => notbORimm,
		 o_O => muxBOut);


adder: fulladder_N
	generic map(N => N)
	port map(i_A => A,
	         i_B => muxBOut,
	         i_Cin => nAdd_Sub,
                 o_Sum => Sum,
	         o_Cout => Cout);
		 

end architecture structural;