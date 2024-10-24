-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- slt.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a component that compares
-- two N bit integers and returns 1 when (input A < input B) and 0 otherwise
--
--
-- NOTES:
-- 10/15/24 by KAB::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity slt is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end slt;

architecture dataflow of slt is
begin

  o_F <= X"00000001" when (i_A < i_B) else X"00000000";
  
end dataflow;