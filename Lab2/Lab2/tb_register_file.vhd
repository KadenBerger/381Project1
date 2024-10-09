-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- tb_register_file.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a register file
-- NOTES:
-- 9/26/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_register_file is
  generic(gCLK_HPER   : time := 50 ns);
end tb_register_file;

architecture behavior of tb_register_file is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer := 32;

  -- Component declaration
component register_file is
	port(regfile_writeEnable: in std_logic;
	     regfile_CLK : in std_logic;
	     regfile_RST : in std_logic;
	     data_In: in std_logic_vector(31 downto 0);
	     srcA: in std_logic_vector(4 downto 0);
	     srcB: in std_logic_vector(4 downto 0);
	     dstReg : in std_logic_vector(4 downto 0);
	     readA: out std_logic_vector(31 downto 0);
	     readB: out std_logic_vector(31 downto 0));
end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_RST, s_WE  : std_logic;
  signal s_data_In, s_readA, s_readB: std_logic_vector(31 downto 0);
  signal s_srcA, s_srcB, s_dstReg : std_logic_vector(4 downto 0);

begin

  DUT: register_file
  port map(regfile_writeEnable => s_WE, 
           regfile_CLK => s_CLK,
           regfile_RST=> S_RST,
           data_In  => s_data_In,
           srcA   => s_srcA,
           srcB  => s_srcB,
           dstReg  => s_dstReg,
           readA  => s_readA,
           readB  => s_readB);

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

    -- init 
	s_RST     <= '1';
	s_WE      <= '1';
	s_dstReg  <= "00000";
	s_srcA    <= "00000";
	s_srcB    <= "00000";
	s_data_In <= X"00000000";
	wait for cCLK_PER;

    -- read and write reg 1 
	s_RST	  <= '0';
	s_WE      <= '1';
	s_data_In <= X"FFFFFFFF";
	s_dstReg  <= "00001";
	s_srcA    <= "00001";
	s_srcB    <= "00001";
	wait for cCLK_PER;

  -- read and write reg 0
	s_WE      <= '1';
	s_data_In <= X"FFFFFFFF";
	s_dstReg  <= "00000";
	s_srcA    <= "00000";
	s_srcB    <= "00000";
	wait for cCLK_PER;

  -- read and write reg 31
	s_WE      <= '1';
	s_data_In <= X"11111111";
	s_dstReg  <= "11111";
	s_srcA    <= "11111";
	s_srcB    <= "11111";
	wait for cCLK_PER;


    

    wait;
  end process;
  
end behavior;