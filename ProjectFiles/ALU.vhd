-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- ALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the ALU implementation
-- NOTES:
-- 10/13/24 by KAB:Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


-- Entity
entity ALU is
    port(input_A 	    : in std_logic_vector(31 downto 0);
	 input_B 	    : in std_logic_vector(31 downto 0);
	 shift_AmountOrByte : in std_logic_vector(4 downto 0);
	 ALUCONTROL 	    : in std_logic_vector(3 downto 0);
	 zero_Flag	    : out std_logic;
	 overflow_Flag	    : out std_logic;
	 carry_Out	    : out std_logic;
	 result	     	    : out std_logic_vector(31 downto 0));
end ALU;

-- Architecture
architecture behavior of ALU is

--Components
component addersubtractor_N is
generic(N : integer := 32);
	port(A : in std_logic_vector(N-1 downto 0);
	     B : in std_logic_vector(N-1 downto 0);
	     nAdd_Sub : in std_logic;
             Sum : out std_logic_vector(N-1 downto 0);
	     Overflow : out std_logic;
	     Carryout : out std_logic);
end component;

component barrel_shifter is
    port(input 	    	 : in std_logic_vector(31 downto 0);
	 shift_Direction : in std_logic; -- 1 for left, 0 for right
	 shift_Amount    : in std_logic_vector(4 downto 0);
	 shift_Type  	 : in std_logic; -- 0 for logical, 1 for arithmetic
	 output	     	 : out std_logic_vector(31 downto 0));
end component;

component mux2t1_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

component andg2_N is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

component org2_N is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

component xorg2_N is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

component norg2_N is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

component slt is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

component replqb is
  port(input          : in std_logic_vector(31 downto 0);
       byte_Select    : in std_logic_vector(1 downto 0);
       o_F            : out std_logic_vector(31 downto 0));
end component;

component andg2 is
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component zero_FlagCheck is
  port(i_A          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic);
end component;


--Signal Declarations
signal temp_Output, adder_Output, shifter_Output, and_Output, or_Output, xor_Output, nor_Output, slt_Output, replqb_Output  : std_logic_vector(31 downto 0);
signal adder_Overflow : std_logic;

begin

adder: addersubtractor_N
port map(A 	  => input_A,
	 B 	  => input_B,
	 nAdd_Sub => ALUCONTROL(0),
         Sum 	  => adder_Output,
	 Overflow => adder_Overflow,
	 Carryout => carry_Out);

shifter: barrel_shifter
port map(input 	    	 => input_B,
	 shift_Direction => ALUCONTROL(0),
	 shift_Amount    => shift_AmountOrByte,
	 shift_Type  	 => ALUCONTROL(1),
	 output	     	 => shifter_Output);

andGate: andg2_N
generic map(N => 32)
port map(i_A          => input_A,
         i_B          => input_B,
         o_F          => and_Output);

orGate: org2_N
generic map(N => 32)
port map(i_A          => input_A,
         i_B          => input_B,
         o_F          => or_Output);

xorGate: xorg2_N
generic map(N => 32)
port map(i_A          => input_A,
         i_B          => input_B,
         o_F          => xor_Output);

norGate: norg2_N
generic map(N => 32)
port map(i_A          => input_A,
         i_B          => input_B,
         o_F          => nor_Output);

sltComponent: slt
generic map(N => 32)
port map(i_A          => input_A,
         i_B          => input_B,
         o_F          => slt_Output);

replqbComponent: replqb
port map(input        => input_A,
         byte_Select  => shift_AmountOrByte(1 downto 0),
         o_F          => replqb_Output);

overflowFlag: andg2
port map(i_A          => adder_Overflow,
         i_B          => ALUCONTROL(3),
         o_F          => overflow_Flag);
		
zeroFlag: zero_FlagCheck
port map(i_A          => adder_Output,
         o_F          => zero_Flag);
-------------------------------------------

with ALUCONTROL(3 downto 0) select 
result <= adder_Output   when "1100", -- add
	  adder_Output   when "1101", -- sub
	  adder_Output   when "0010", -- addu
	  adder_Output   when "0011", -- subu
	  shifter_Output when "0100", -- srl
	  shifter_Output when "0101", -- sll
	  shifter_Output when "0110", -- sra
	  and_Output	 when "0111", -- AND
	  or_Output	 when "1000", -- OR
	  xor_Output	 when "1001", -- XOR
	  nor_Output	 when "1010", -- NOR
	  slt_Output	 when "1011", -- SLT
	  replqb_Output  when "1111", -- repl.qb 
	  X"00000000" when others;

end behavior;

