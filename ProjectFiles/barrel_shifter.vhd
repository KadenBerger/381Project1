-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of 32 bit barrel shifter with arithmetic
-- and logical shifting
-- NOTES:
-- 10/8/24 by KAB::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


-- Entity
entity barrel_shifter is
    port(input 	    	 : in std_logic_vector(31 downto 0);
	 shift_Direction : in std_logic; -- 0 for right, 1 for left
	 shift_Amount    : in std_logic_vector(4 downto 0);
	 shift_Type  	 : in std_logic; -- 0 for logical, 1 for arithmetic
	 output	     	 : out std_logic_vector(31 downto 0));
end barrel_shifter;

-- Architecture
architecture behavior of barrel_shifter is

component mux2t1_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

--Signal Declarations
signal new_Input, leftLogicalOutput, stage1_out, stage2_out, stage3_out, stage4_out, stage5_out : std_logic_vector(31 downto 0);
signal stage2_ShiftedInput, stage3_ShiftedInput, stage4_ShiftedInput, stage5_ShiftedInput : std_logic_vector(31 downto 0);
signal shift_Input : std_logic;  --this is 0 when doing logical shift and 1 when doing arithmetic shift

begin


--Set shift input based on shift type and the most significant bit
shift_Input <= shift_Type and input(31);

--Reverse the output if incase we want left logical shift value
new_Input <= input(0) & input(1) & input(2) & input(3) & input(4) & input(5) & input(6) 
& input(7) & input(8) & input(9) & input(10) & input(11) & input(12) & input(13) &
input(14) & input(15) & input(16) & input(17) & input(18) & input(19) & input(20) & 
input(21) & input(22) & input(23) & input(24) & input(25) & input(26) & input(27) & 
input(28) & input(29) & input(30) & input(31) when shift_Direction = '1' else input;

-----------------------------------
-- 0 or 1 bit shift
stage1: mux2t1_N
port map(i_S  => shift_Amount(0), -- 0 or 1 bits
	 i_D0 => new_Input,
	 i_D1 => shift_Input & new_Input(31 downto 1),
	 o_O  => stage1_out);

-----------------------------------

--shift so it can be put in mux
stage2_ShiftedInput(31 downto 30) <= (others => shift_input);
stage2_ShiftedInput(29 downto 0)  <= stage1_out(31 downto 2);

-- 0 or 2 bit shift
stage2: mux2t1_N
port map(i_S  => shift_Amount(1), -- 0 or 2 bits
	 i_D0 => stage1_out,
	 i_D1 => stage2_ShiftedInput,
	 o_O  => stage2_out);

-----------------------------------

stage3_ShiftedInput(31 downto 28) <= (others => shift_input);
stage3_ShiftedInput(27 downto 0)  <= stage2_out(31 downto 4);

-- 0 or 4 bit shift
stage3: mux2t1_N
port map(i_S  => shift_Amount(2),
	 i_D0 => stage2_out,
	 i_D1 => stage3_ShiftedInput,
	 o_O  => stage3_out);

-----------------------------------

stage4_ShiftedInput(31 downto 24) <= (others => shift_input);
stage4_ShiftedInput(23 downto 0)  <=  stage3_out(31 downto 8);

-- 0 or 8 bit shift
stage4: mux2t1_N
port map(i_S  => shift_Amount(3),
	 i_D0 => stage3_out,
	 i_D1 => stage4_ShiftedInput,
	 o_O  => stage4_out);

-----------------------------------

stage5_ShiftedInput(31 downto 16) <= (others => shift_input);
stage5_ShiftedInput(15 downto 0)  <=stage4_out(31 downto 16);

-- 0 or 16 bit shift
stage5: mux2t1_N
port map(i_S  => shift_Amount(4),
	 i_D0 => stage4_out,
	 i_D1 => stage5_ShiftedInput,
	 o_O  => stage5_out);

----------------------------------
--Reverse the output if incase we want left logical shift value
leftLogicalOutput <= stage5_out(0) & stage5_out(1) & stage5_out(2) & stage5_out(3) & stage5_out(4) & stage5_out(5) & stage5_out(6) 
& stage5_out(7) & stage5_out(8) & stage5_out(9) & stage5_out(10) & stage5_out(11) & stage5_out(12) & stage5_out(13) &
stage5_out(14) & stage5_out(15) & stage5_out(16) & stage5_out(17) & stage5_out(18) & stage5_out(19) & stage5_out(20) & 
stage5_out(21) & stage5_out(22) & stage5_out(23) & stage5_out(24) & stage5_out(25) & stage5_out(26) & stage5_out(27) & 
stage5_out(28) & stage5_out(29) & stage5_out(30) & stage5_out(31) when shift_Direction = '1' else stage5_out;

outputSelect: mux2t1_N
port map(i_S  => shift_Direction,
	 i_D0 => stage5_out,
	 i_D1 => leftLogicalOutput,
	 o_O  => output);

end behavior;


