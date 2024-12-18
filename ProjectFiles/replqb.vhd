-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- replqb.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a component that performs the
-- repl.qb mips command which takes the selected byte from and input and 
-- copies it 4 times to the output
--
-- NOTES:
-- 10/15/24 by KAB::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity replqb is
  port(input          : in std_logic_vector(31 downto 0);
       byte_Select    : in std_logic_vector(1 downto 0);
       o_F            : out std_logic_vector(31 downto 0));
end replqb;
 
architecture behavior of replqb is

signal selected_Byte : std_logic_vector(7 downto 0);
begin

	process(input, byte_Select)
	begin
		if(byte_Select = "00") then
			selected_Byte <= input(7 downto 0);
		elsif(byte_Select = "01") then
			selected_Byte <= input(15 downto 8);
		elsif(byte_Select = "10") then
			selected_Byte <= input(23 downto 16);
		elsif(byte_Select = "11") then
			selected_Byte <= input(31 downto 24);
		else
			selected_Byte <= "00000000";
		end if;

	end process;

		o_F <= selected_Byte & selected_Byte & selected_Byte & selected_Byte;
end behavior;