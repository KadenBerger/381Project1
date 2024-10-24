


-- pc_fetch_logic_dffg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an edge-triggered
-- flip-flop with parallel access and reset.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity pc_fetch_logic_dffg is

  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_RST_data   : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output

end pc_fetch_logic_dffg;

architecture mixed of pc_fetch_logic_dffg is
  -- signal s_D    : std_logic;    -- Multiplexed input to the FF
  signal s_Q    : std_logic;    -- Output of the FF

begin

  -- The output of the FF is fixed to s_Q
  o_Q <= s_Q;
    
  -- This process handles the asyncrhonous reset and synchronous write. 

process (i_CLK, i_RST)
  begin
    if (i_RST = '1') then
      s_Q <= i_RST_data; -- Use "(others => '0')" for N-bit values
    elsif (rising_edge(i_CLK)) then
      s_Q <= i_D;
    end if;

  end process;
  
end mixed;