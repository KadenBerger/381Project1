-------------------------------------------------------------------------
-- pc_fetch_logic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32-bit positive edge 
-- d-flip-flop with reset, it then stores the PC value.
-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration

entity pc_fetch_logic is
 
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_D          : in std_logic_vector(31 downto 0);     -- input the data value 
       o_Q          : out std_logic_vector(31 downto 0));   -- output the data value 

end pc_fetch_logic;

-- Architecture of the PC fetch logic

architecture structural of pc_fetch_logic is

component pc_fetch_logic_dffg is

port(
i_CLK        : in std_logic;     -- Clock input
i_RST        : in std_logic;     -- Reset input
i_RST_data   : in std_logic;     -- Write enable input
i_D          : in std_logic;     -- Data value input
o_Q          : out std_logic);   -- Data value output

end component;

signal s_RST_data : std_logic_vector(31 downto 0) := X"00400000"; --Internal signal

begin

  -- It has 32 instances of the dff
  g_Nbit_dffg: for i in 0 to 31 generate
    onescompi: pc_fetch_logic_dffg 

port map(
i_CLK      => i_CLK,  -- all dff share the same clock
i_RST	   => i_RST,  -- all dff share the same reset
i_RST_data => s_RST_data(i),   -- reset data for every bit
i_D	   => i_D(i), -- input PC value
o_Q        => o_Q(i));-- output PC value

end generate g_Nbit_dffg;
  
end structural;