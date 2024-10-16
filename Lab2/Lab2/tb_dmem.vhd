-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_dmem.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the addersubtractor_N unit.
--              
-- 09/26/2024 by Kaden::Design created.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_dmem is
  generic(gCLK_HPER   : time := 50 ns);
end tb_dmem;

architecture behavior of tb_dmem is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

component mem is
	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);
	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end component;


  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_we : std_logic;
  signal s_data, s_q : std_logic_vector(31 downto 0);
  signal s_addr      : std_logic_vector(9 downto 0);

begin

  DMEM : mem 
  port map(clk => s_CLK, 
           addr => s_addr,
           data  => s_data,
           we   => s_we,
           q   => s_q);

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



    s_addr   <= "0000000000";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0000000001";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0000000010";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0000000011";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

     s_addr  <= "0000000100";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0000000101";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0000000110";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0000000111";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0000001000";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0000001001";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

-- part 2

    s_addr   <= "0100000000";
    s_data   <= X"FFFFFFFF";
    s_we     <= '1';
    wait for cCLK_PER;

    s_addr   <= "0100000001";
    s_data   <= X"00000002";
    s_we     <= '1';
    wait for cCLK_PER;

    s_addr   <= "0100000010";
    s_data   <= X"FFFFFFFD";
    s_we     <= '1';
    wait for cCLK_PER;

    s_addr   <= "0100000011";
    s_data   <= X"00000004";
    s_we     <= '1';
    wait for cCLK_PER;

     s_addr   <= "0100000100";
    s_data   <= X"00000005";
    s_we     <= '1';
    wait for cCLK_PER;

    s_addr   <= "0100000101";
    s_data   <= X"00000006";
    s_we     <= '1';
    wait for cCLK_PER;

    s_addr   <= "0100000110";
    s_data   <= X"FFFFFFF9";
    s_we     <= '1';
    wait for cCLK_PER;

    s_addr   <= "0100000111";
    s_data   <= X"FFFFFFF8";
    s_we     <= '1';
    wait for cCLK_PER;

    s_addr   <= "0100001000";
    s_data   <= X"00000009";
    s_we     <= '1';
    wait for cCLK_PER;

    s_addr   <= "0100001001";
    s_data   <= X"FFFFFFF6";
    s_we     <= '1';
    wait for cCLK_PER;

-- part 3

    s_addr   <= "0100000000";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0100000001";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0100000010";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0100000011";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0100000100";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0100000101";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0100000110";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0100000111";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0100001000";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;

    s_addr   <= "0100001001";
    s_data   <= X"00000000";
    s_we     <= '0';
    wait for cCLK_PER;


    wait;
  end process;
  
end behavior;
