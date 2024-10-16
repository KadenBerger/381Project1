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
-- 10/8/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


-- Entity
entity barrel_shifter is
    port(input 	      : in std_logic_vector(31 downto 0);
	 shift_Amount : in std_logic_vector(4 downto 0);
	 shift_Type   : in std_logic; -- 0 for logical, 1 for arithmetic
	 output	      : out std_logic_vector(31 downto 0));
end barrel_shifter;

-- Architecture
architecture behavior of barrel_shifter is

--Signal Declarations
signal logical_shift, arithmetic_shift : std_logic_vector(31 downto 0);
begin
	--Logic Shift
	logical_shift <= std_logic_vector(shift_right(unsigned(input), to_integer(unsigned(shift_Amount))));

	--Arithmetic Shift
	arithmetic_shift <= std_logic_vector(shift_right(signed(input), to_integer(unsigned(shift_Amount))));

	Output <= logical_shift when shift_Type = '0'
	else 
	arithmetic_shift;
  
end behavior;


