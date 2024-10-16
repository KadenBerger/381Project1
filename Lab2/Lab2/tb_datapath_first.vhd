-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- tb_datapath_first.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an testbench for the first datapath
-- NOTES:
-- 9/26/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_datapath_first is
  generic(gCLK_HPER   : time := 50 ns);
end tb_datapath_first;

architecture behavior of tb_datapath_first is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer := 32;

  -- Component declaration
component datapath_first is
	port(i_WE : in std_logic;
	     i_CLK     : in std_logic;
	     i_RST     : in std_logic;
	     i_dataIn  : in std_logic_vector(31 downto 0);
	     i_srcA    : in std_logic_vector(4 downto 0);
 	     i_srcB    : in std_logic_vector(4 downto 0);
	     i_destReg : in std_logic_vector(4 downto 0);
	     o_readA   : out std_logic_vector(31 downto 0);
	     o_readB   : out std_logic_vector(31 downto 0);
	     i_imm     : in std_logic_vector(31 downto 0);
	     i_nAdd_Sub: in std_logic;
	     i_ALUSrc  : in std_logic);

end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_RST, s_WE, s_nAdd_Sub, s_ALUSrc  : std_logic;
  signal s_data_In, s_readA, s_readB, s_imm : std_logic_vector(31 downto 0);
  signal s_srcA, s_srcB, s_dstReg : std_logic_vector(4 downto 0);

begin

  DUT: datapath_first
  port map(i_WE => s_WE, 
           i_CLK => s_CLK,
           i_RST => S_RST,
           i_dataIn  => s_data_In,
           i_srcA   => s_srcA,
           i_srcB  => s_srcB,
           i_destReg  => s_dstReg,
           o_readA  => s_readA,
           o_readB  => s_readB,
   	   i_imm  => s_imm,
   	   i_nAdd_Sub  => s_nAdd_Sub,
    	   i_ALUSrc  => s_ALUSrc);

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

    -- addi $1, $0, 1
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "00001";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"00000001";
	wait for cCLK_PER;

  -- check on both reads that register 1 has value of 1
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "00001";
	s_srcB     <= "00001";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- addi $2, $0, 2
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "00010";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"00000002";
	wait for cCLK_PER;

  -- check on both reads that register 2 has value of 2 
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "00010";
	s_srcB     <= "00010";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- addi $3, $0, 3
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "00011";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"00000003";
	wait for cCLK_PER;

  -- check on both reads that register 3 has value of 3
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "00011";
	s_srcB     <= "00011";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- addi $4, $0, 4
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "00100";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"00000004";
	wait for cCLK_PER;

  -- check on both reads that register 4 has value of 4 
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "00100";
	s_srcB     <= "00100";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- addi $5, $0, 5
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "00101";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"00000005";
	wait for cCLK_PER;

  -- check on both reads that register 5 has value of 5
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "00101";
	s_srcB     <= "00101";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- addi $6, $0, 6
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "00110";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"00000006";
	wait for cCLK_PER;

  -- check on both reads that register 6 has value of 6
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "00110";
	s_srcB     <= "00110";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- addi $7, $0, 7
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "00111";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"00000007";
	wait for cCLK_PER;

  -- check on both reads that register 7 has value of 7
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "00111";
	s_srcB     <= "00111";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- addi $8, $0, 8
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "01000";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"00000008";
	wait for cCLK_PER;

  -- check on both reads that register 8 has value of 8
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "01000";
	s_srcB     <= "01000";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- addi $9, $0, 9
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "01001";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"00000009";
	wait for cCLK_PER;

  -- check on both reads that register 9 has value of 9
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "01001";
	s_srcB     <= "01001";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- addi $10, $0, 10
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "01010";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"0000000A";
	wait for cCLK_PER;

  -- check on both reads that register 10 has value of 10
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "01010";
	s_srcB     <= "01010";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- add $11, $1, $2
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "01011";
	s_srcA     <= "00001";
	s_srcB     <= "00010";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

  -- check on both reads that register 11 has value of 3
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "01011";
	s_srcB     <= "01011";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- sub $12, $11, $3
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '1';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "01100";
	s_srcA     <= "01011";
	s_srcB     <= "00011";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

  -- check on both reads that register 12 has value of 0
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "01100";
	s_srcB     <= "01100";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- add $13, $12, $4
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "01101";
	s_srcA     <= "01100";
	s_srcB     <= "00100";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

  -- check on both reads that register 13 has value of 4
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "01101";
	s_srcB     <= "01101";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- sub $14, $13, $5
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '1';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "01110";
	s_srcA     <= "01101";
	s_srcB     <= "00101";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

  -- check on both reads that register 14 has value of -1
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "01110";
	s_srcB     <= "01110";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- add $15, $14, $6
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "01111";
	s_srcA     <= "01110";
	s_srcB     <= "00110";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

  -- check on both reads that register 15 has value of 5
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "01111";
	s_srcB     <= "01111";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- sub $16, $15, $7
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '1';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "10000";
	s_srcA     <= "01111";
	s_srcB     <= "00111";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

  -- check on both reads that register 16 has value of -2
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "10000";
	s_srcB     <= "10000";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- add $17, $16, $8
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "10001";
	s_srcA     <= "10000";
	s_srcB     <= "01000";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

  -- check on both reads that register 17 has value of 6
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "10001";
	s_srcB     <= "10001";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- sub $18, $17, $9
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '1';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "10010";
	s_srcA     <= "10001";
	s_srcB     <= "01001";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

  -- check on both reads that register 18 has value of -3
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "10010";
	s_srcB     <= "10010";
	s_imm      <= X"00000000";
	wait for cCLK_PER;
    
    -- add $19, $18, $10
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "10011";
	s_srcA     <= "10010";
	s_srcB     <= "01010";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

  -- check on both reads that register 19 has value of 7
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "10011";
	s_srcB     <= "10011";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- addi $20, $0, -35
	s_ALUSrc   <= '1';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "10100";
	s_srcA     <= "00000";
	s_srcB     <= "00000";
	s_imm      <= X"FFFFFFDD";
	wait for cCLK_PER;

  -- check on both reads that register 20 has value of -35
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "10100";
	s_srcB     <= "10100";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    -- add $21, $19, $20
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '1';
	s_dstReg   <= "10101";
	s_srcA     <= "10011";
	s_srcB     <= "10100";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

  -- check on both reads that register 21 has value of -28
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "10101";
	s_srcB     <= "10101";
	s_imm      <= X"00000000";
	wait for cCLK_PER;


  -- check on both reads that register 21 has value of -28
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "10111";
	s_srcB     <= "10111";
	s_imm      <= X"00000000";
	wait for cCLK_PER;

    wait;
  end process;
  
end behavior;