
-- tb_fetch_logic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for an d-flip-flop
-- parallel load and reset
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity tb_pc_fetch_logic is
  generic(gCLK_HPER   : time := 50 ns);
end tb_pc_fetch_logic;

architecture behavior of tb_pc_fetch_logic is
  
  -- Calculate the clock period as twice the half-period
  --constant cCLK_PER  : time := gCLK_HPER * 2;


  component pc_fetch_logic
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_D          : in std_logic_vector(31 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(31 downto 0));   -- Data value output
  end component;

  -- Temporary signals to connect to the dff component.

  signal s_CLK, s_RST : std_logic;
  signal s_D, s_Q : std_logic_vector(31 downto 0);

begin

  DUT:pc_fetch_logic 

  port map(i_CLK => s_CLK, 
           i_RST => s_RST,
           i_D   => s_D,
           o_Q   => s_Q);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
    -- Reset the FF
    s_RST <= '1';
    s_D   <= X"00000000";
    wait for gCLK_HPER;

    -- Store X"FFFFFFFF"
    s_RST <= '0';
    s_D   <= X"FFFFFFFF";
    wait for gCLK_HPER;  

    -- Keep X"FFFFFFFF"
    s_RST <= '0';
    s_D   <= X"00000000";
    wait for gCLK_HPER;  

    -- Store '0'    
    s_RST <= '1';
    s_D   <= X"00000000";
    wait for gCLK_HPER;  

    -- Keep '0'
    s_RST <= '0';
    s_D   <= X"FFFFFFFF";
    wait for gCLK_HPER;  

    wait;
  end process;
  
end behavior;