-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- multiplexer_32to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32 to 1 multiplexer using
-- a dataflow implementation
--
-- NOTES:
-- 9/24/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

type input_array is array 0 to 31 of std_logic_vector(31 downto 0);

signal input_array_signal: input_array;