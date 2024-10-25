-------------------------------------------------------------------------
-- tb_fetch_logic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for an d-flip-flop
-- parallel load and reset
-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--Entity Declaration 

entity tb_pc_fetch_logic is

  generic(gCLK_HPER   : time := 50 ns); --half period clk

end tb_pc_fetch_logic;

--Architecture of the testbench of the pc fetch logic

architecture behavior of tb_pc_fetch_logic is
  
component pc_fetch_logic

port
	(i_CLK        : in std_logic;     -- Clock input
	 i_RST        : in std_logic;     -- Reset input
         i_D          : in std_logic_vector(31 downto 0);     -- Data value input
         o_Q          : out std_logic_vector(31 downto 0));   -- Data value output

end component;

signal s_CLK, s_RST : std_logic;
signal s_D, s_Q : std_logic_vector(31 downto 0);

begin

  DUT:pc_fetch_logic 

port map(i_CLK => s_CLK, 
         i_RST => s_RST,
         i_D   => s_D,
         o_Q   => s_Q);
	
P_CLK: process

begin

s_CLK <= '0';
wait for gCLK_HPER;

s_CLK <= '1';
wait for gCLK_HPER;

end process;
  
  -- Testbench process for the test cases

P_TB: process

begin

-- resets the dff
s_RST <= '1';
s_D   <= X"00000000";
wait for gCLK_HPER;

-- load X"FFFFFFFF" into dff 
s_RST <= '0';
s_D   <= X"FFFFFFFF";
wait for gCLK_HPER;  

-- hold value X"FFFFFFFF" into dff basically holding the previous value
s_RST <= '0';
s_D   <= X"00000000";
wait for gCLK_HPER;  

-- resets the dff    
s_RST <= '1';
s_D   <= X"00000000";
wait for gCLK_HPER;  

-- load input 0 
s_RST <= '0';
s_D   <= X"FFFFFFFF";
wait for gCLK_HPER;  

wait;

end process;
  
end behavior;