-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- xorg2_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input XOR 
-- gate with support for N bit inputs.
--
--
-- NOTES:
-- 10/15/24 by KAB::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity xorg2_N is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end xorg2_N;

architecture dataflow of xorg2_N is
begin

  o_F <= i_A xor i_B;
  
end dataflow;