-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- norg2_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of nor gate component
--
-- NOTES:
-- 10/15/24 by KAB::Design created.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity norg2_N is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end norg2_N;

architecture dataflow of norg2_N is
begin

  o_F <= not(i_A or i_B);
  
end dataflow;