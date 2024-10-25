
-------------------------------------------------------------------------
-- pc_fetch_logic_dffg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an edge-triggered
-- dff with a reset and preset data, this stores single bits of data.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

--Entity Declaration

entity pc_fetch_logic_dffg is

  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_RST_data   : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output

end pc_fetch_logic_dffg;

--Architecture of the pc fetch logic dffg

architecture mixed of pc_fetch_logic_dffg is
  
  signal s_Q    : std_logic;    -- This is the store bit value in the dff

begin

  -- Output signal to the output port

  o_Q <= s_Q;
    
  -- This process does reset and data storage

process (i_CLK, i_RST)

begin

if (i_RST = '1') then

s_Q <= i_RST_data; -- this rests the reset data value

elsif (rising_edge(i_CLK)) then -- updates output with data input

s_Q <= i_D;

end if;

end process;
  
end mixed;