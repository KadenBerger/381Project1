-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- zero_FlagCheck.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a zero check component
-- that returns 1 if the input is all 0's and 0 otherwise.
--
-- NOTES:
-- 10/15/24 by KAB::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity zero_FlagCheck is
  port(i_A          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic);

end zero_FlagCheck;

architecture behavior of zero_FlagCheck is

--Temp variable to store output of the nor
begin

  process(i_A)
	begin
	
		if(i_A = X"00000000") then
			o_F <= '1';
		else
			o_F <= '0';
		end if;
	end process;
  
end behavior;