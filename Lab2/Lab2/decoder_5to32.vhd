-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- decoder_5to32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an 5 to 32 decoder using 
-- a dataflow implementation
--
--
-- NOTES:
-- 9/24/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity
entity decoder_5to32 is
	port(enable : in std_logic;
	decoderIn	: in std_logic_vector(4 downto 0);
	decoderOut	: out std_logic_vector(31 downto 0));
end decoder_5to32;

--architecture
architecture Dataflow of decoder_5to32 is
begin process(enable, decoderIn)
	begin
	if enable = '1' then
	with decoderIn select
decoderOut <= X"00000001" when "00000", -- 0
	      X"00000002" when "00001", -- 1
	      X"00000004" when "00010", -- 2
	      X"00000008" when "00011", -- 3
	      X"00000010" when "00100", -- 4
	      X"00000020" when "00101", -- 5
	      X"00000040" when "00110", -- 6
	      X"00000080" when "00111", -- 7
	      X"00000100" when "01000", -- 8
	      X"00000200" when "01001", -- 9
	      X"00000400" when "01010", -- 10
	      X"00000800" when "01011", -- 11
	      X"00001000" when "01100", -- 12
	      X"00002000" when "01101", -- 13
	      X"00004000" when "01110", -- 14
	      X"00008000" when "01111", -- 15
	      X"00010000" when "10000", -- 16
	      X"00020000" when "10001", -- 17
	      X"00040000" when "10010", -- 18
	      X"00080000" when "10011", -- 19
	      X"00100000" when "10100", -- 20
	      X"00200000" when "10101", -- 21
	      X"00400000" when "10110", -- 22
	      X"00800000" when "10111", -- 23
	      X"01000000" when "11000", -- 24
	      X"02000000" when "11001", -- 25
	      X"04000000" when "11010", -- 26
	      X"08000000" when "11011", -- 27
	      X"10000000" when "11100", -- 28
	      X"20000000" when "11101", -- 29
	      X"40000000" when "11110", -- 30
	      X"80000000" when "11111", -- 31
	      X"00000000" when others; 
	else
	decoderOut <= X"00000000";
	end if;
end process;
end Dataflow;