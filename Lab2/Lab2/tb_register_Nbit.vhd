-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_registerNbit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- edge-triggered N bit register component
--
--
-- NOTES:
-- 9/24/24 by Kaden::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_register_Nbit is
  generic(gCLK_HPER   : time := 50 ns);
end tb_register_Nbit;

architecture behavior of tb_register_Nbit is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer := 32;

component register_Nbit is
generic(N : integer := 32);
	port(clock: in std_logic;
	     reset: in std_logic;
	     writeEnable: in std_logic;
	     dataIn: in std_logic_vector(N-1 downto 0);
	     dataOut: out std_logic_vector(N-1 downto 0));
end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_RST, s_WE  : std_logic;
  signal s_D, s_Q: std_logic_vector(N-1 downto 0);

begin

  DUT: register_Nbit
  port map(clock => s_CLK, 
           reset => s_RST,
           writeEnable  => s_WE,
           dataIn   => s_D,
           dataOut  => s_Q);

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
    s_WE  <= '0';
    s_D   <= X"00000000";
    wait for cCLK_PER;

    -- Store '1'
    s_RST <= '0';
    s_WE  <= '1';
    s_D   <= X"11111111";
    wait for cCLK_PER;  

    -- Keep '1'
    s_RST <= '0';
    s_WE  <= '0';
    s_D   <= X"00000000";
    wait for cCLK_PER;  

    -- Store '0'    
    s_RST <= '0';
    s_WE  <= '1';
    s_D   <= X"00000000";
    wait for cCLK_PER;  

    -- Keep '0'
    s_RST <= '0';
    s_WE  <= '0';
    s_D   <= X"11111111";
    wait for cCLK_PER;  

    wait;
  end process;
  
end behavior;