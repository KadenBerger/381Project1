-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- sign_extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/28/24:Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity sign_extender is
	port(extensionMode   : in std_logic;
	     i_Imm           : in std_logic_vector(15 downto 0);
             o_Extended      : out std_logic_vector(31 downto 0));
end sign_extender;

--architecture
architecture Behavioral of sign_extender is

begin

	process(i_Imm, extensionMode)
	begin

	-- 1 is sign extension
	if extensionMode = '1' then 
		o_Extended <= std_logic_vector(resize(signed(i_Imm), 32));
	else 
		-- else zero extension
		o_Extended <= X"0000" & i_Imm;
	end if;

	end process;
	
end Behavioral;
	