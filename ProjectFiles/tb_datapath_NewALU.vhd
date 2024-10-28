-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- tb_datapath_NewALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for the second datapath
-- NOTES:
-- 9/29/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_datapath_NewALU is
  generic(gCLK_HPER   : time := 50 ns);
end tb_datapath_NewALU;

architecture behavior of tb_datapath_NewALU is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer := 32;

  -- Component declaration
component datapath_NewALU is
	port(i_WE	      : in std_logic;
	     i_CLK    	      : in std_logic;
	     i_RST    	      : in std_logic;
	     i_srcA   	      : in std_logic_vector(4 downto 0);
 	     i_srcB    	      : in std_logic_vector(4 downto 0);
	     i_destReg 	      : in std_logic_vector(4 downto 0);
	     o_readA   	      : out std_logic_vector(31 downto 0);
	     o_readB  	      : out std_logic_vector(31 downto 0);
	     i_imm     	      : in std_logic_vector(15 downto 0);
	     i_immSelect      : in std_logic;
	     i_ShiftAmount    : in std_logic_vector(4 downto 0);
	     i_ALUCONTROL     : in std_logic_vector(3 downto 0);
	     i_mem2reg 	      : in std_logic;
	     i_dataMemoryWE   : in std_logic;
	     i_extensionMode  : in std_logic;
	     flag_Zero	      : out std_logic;
	     flag_Overflow    : out std_logic);
end component;


  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_RST, s_WE, s_immSelect, s_mem2reg, s_extensionMode, s_dataMemoryWE, s_FlagZero, s_FlagOverflow : std_logic;
  signal s_readA, s_readB, s_ExpectedValue : std_logic_vector(31 downto 0);
  signal s_srcA, s_srcB, s_dstReg, s_shiftAmount : std_logic_vector(4 downto 0);
  signal s_ALUCONTROL : std_logic_vector(3 downto 0);
  signal s_imm : std_logic_vector(15 downto 0);

begin

        DUT: datapath_NewALU
	port map(i_WE	          => s_WE,
	    	 i_CLK    	  => s_CLK,
	    	 i_RST    	  => s_RST,
	    	 i_srcA   	  => s_srcA,
 	    	 i_srcB    	  => s_srcB,
	    	 i_destReg 	  => s_dstReg, 
	    	 o_readA   	  => s_readA,
	    	 o_readB  	  => s_readB,
	    	 i_imm     	  => s_imm,
	    	 i_immSelect      => s_immSelect,
	    	 i_ShiftAmount    => s_shiftAmount,
	    	 i_ALUCONTROL     => s_ALUCONTROL,
	   	 i_mem2reg 	  => s_mem2reg,
	    	 i_dataMemoryWE   => s_dataMemoryWE,
	   	 i_extensionMode  => s_extensionMode,
	   	 flag_Zero	  => s_FlagZero,
	   	 flag_Overflow    => s_FlagOverflow);

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

		 -- base format 
		 s_WE	          <= '0';
	    	 s_RST    	  <= '1';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00000";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- addi $1, $0, 0xFFFF 
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00000";
	    	 s_dstReg 	  <= "00001"; 
	    	 s_imm     	  <= X"FFFF";
	    	 s_immSelect      <= '1';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1100";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $1 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00001";
 	    	 s_srcB    	  <= "00001";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"0000FFFF";
		 wait for cCLK_PER;

--Testing add overflow, and sll

		 --addi $2, $0, 0x7FFF
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00000";
	    	 s_dstReg 	  <= "00010"; 
	    	 s_imm     	  <= X"7FFF";
	    	 s_immSelect      <= '1';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1100";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 --sll $2, $2, 4
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00010";
	    	 s_dstReg 	  <= "00010"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "10000";
	    	 s_ALUCONTROL     <= "0101";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $2 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00010";
 	    	 s_srcB    	  <= "00010";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"7FFF0000";
		 wait for cCLK_PER;

		 --addi $2, $2, 0xFFFF	-- get 0x7FFFFFFF in register 2
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00010";
 	    	 s_srcB    	  <= "00000";
	    	 s_dstReg 	  <= "00010"; 
	    	 s_imm     	  <= X"FFFF";
	    	 s_immSelect      <= '1';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1100";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- addi $1, $0, 0x1   -- get 0x00000001 in register 1
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00000";
	    	 s_dstReg 	  <= "00001"; 
	    	 s_imm     	  <= X"0001";
	    	 s_immSelect      <= '1';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1100";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- add $3, $2, $1   -- add 1 and 2 to generate overflow
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00010"; -- 0x7FFFFFFF
 	    	 s_srcB    	  <= "00001"; -- 0x00000001
	    	 s_dstReg 	  <= "00011"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1100";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $3 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00011";
 	    	 s_srcB    	  <= "00011";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"80000000";
		 wait for cCLK_PER;


		 -- addu $3, $2, $1   -- (no overflow addu
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00010"; -- 0x7FFFFFFF
 	    	 s_srcB    	  <= "00001"; -- 0x00000001
	    	 s_dstReg 	  <= "00011"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0010";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $3 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00011";
 	    	 s_srcB    	  <= "00011";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"80000000";
		 wait for cCLK_PER;

		-- sub $4, $3, $1   (sub overflow)
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00011"; -- 0x80000000
 	    	 s_srcB    	  <= "00001"; -- 0x00000001
	    	 s_dstReg 	  <= "00100"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1101";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $4 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00100";
 	    	 s_srcB    	  <= "00100";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"7FFFFFFF";
		 wait for cCLK_PER;

		-- subu $4, $3, $1   (subu no overflow)
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00011"; -- 0x80000000
 	    	 s_srcB    	  <= "00001"; -- 0x00000001
	    	 s_dstReg 	  <= "00100"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0011";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $4 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00100";
 	    	 s_srcB    	  <= "00100";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"7FFFFFFF";
		 wait for cCLK_PER;


		-- SHIFT TESTS


		 --sll $5, $1, 31  (MAX LEFT SHIFT)
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00001";
	    	 s_dstReg 	  <= "00101"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "11111";
	    	 s_ALUCONTROL     <= "0101";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $5 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00101";
 	    	 s_srcB    	  <= "00101";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"80000000";
		 wait for cCLK_PER;

		 --srl $6, $5, 31  (MAX RIGHT SHIFT)
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00101";
	    	 s_dstReg 	  <= "00110"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "11111";
	    	 s_ALUCONTROL     <= "0100";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $6 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00110";
 	    	 s_srcB    	  <= "00110";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000001";
		 wait for cCLK_PER;

		 --sra $6, $5, 31  (MAX RIGHT ARITHMETIC SHIFT)
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00101";
	    	 s_dstReg 	  <= "00110"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "11111";
	    	 s_ALUCONTROL     <= "0110";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $6 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00110";
 	    	 s_srcB    	  <= "00110";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"FFFFFFFF";
		 wait for cCLK_PER;

		-- LOGIC OPERATIONS (and, or, xor, etc) (not really edge cases for these)

		 -- addi $7, $0, 0x9248 (1001001001001000)
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00000";
	    	 s_dstReg 	  <= "00111"; 
	    	 s_imm     	  <= X"9248";
	    	 s_immSelect      <= '1';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1100";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- addi $8, $0, 0xFF64  (1111111101100100)
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00000";
	    	 s_dstReg 	  <= "01000"; 
	    	 s_imm     	  <= X"FF64";
	    	 s_immSelect      <= '1';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1100";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- and $9, $8. $7
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01000";
 	    	 s_srcB    	  <= "00111";
	    	 s_dstReg 	  <= "01001"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0111";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $9 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01001";
 	    	 s_srcB    	  <= "01001";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00009240";
		 wait for cCLK_PER;

		 -- or $9, $8. $7
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01000";
 	    	 s_srcB    	  <= "00111";
	    	 s_dstReg 	  <= "01001"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $9 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01001";
 	    	 s_srcB    	  <= "01001";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"0000FF6C";
		 wait for cCLK_PER;

		 -- xor $9, $8. $7
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01000";
 	    	 s_srcB    	  <= "00111";
	    	 s_dstReg 	  <= "01001"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1001";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $9 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01001";
 	    	 s_srcB    	  <= "01001";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00006D2C";
		 wait for cCLK_PER;

		 -- nor $9, $8, $7
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01000";
 	    	 s_srcB    	  <= "00111";
	    	 s_dstReg 	  <= "01001"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1010";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $9 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01001";
 	    	 s_srcB    	  <= "01001";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"FFFF0093";
		 wait for cCLK_PER;

		-- SLT and REPLQB

		 -- addi $10, $0, 0xFFFF
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00000";
	    	 s_dstReg 	  <= "01010"; 
	    	 s_imm     	  <= X"FFFF";
	    	 s_immSelect      <= '1';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1100";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- slt $11, $1 $10  -basic operation
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00001";
 	    	 s_srcB    	  <= "01010";
	    	 s_dstReg 	  <= "01011"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1011";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $11 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01011";
 	    	 s_srcB    	  <= "01011";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000001";
		 wait for cCLK_PER;

		 -- slt $11, $10 $1 -- basic operation
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01010";
 	    	 s_srcB    	  <= "00001";
	    	 s_dstReg 	  <= "01011"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1011";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $11 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01011";
 	    	 s_srcB    	  <= "01011";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- slt $11, $8 $10  - test with negative
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01000";
 	    	 s_srcB    	  <= "01010";
	    	 s_dstReg 	  <= "01011"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1011";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $11 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01011";
 	    	 s_srcB    	  <= "01011";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000001";
		 wait for cCLK_PER;

		 -- slt $11, $10 $8  - test with negative
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01010";
 	    	 s_srcB    	  <= "01000";
	    	 s_dstReg 	  <= "01011"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1011";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $11 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01011";
 	    	 s_srcB    	  <= "01011";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- slt $11, $0 $0  - test with equal registers
		 s_WE	          <= '1';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "00000";
 	    	 s_srcB    	  <= "00000";
	    	 s_dstReg 	  <= "01011"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "1011";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;

		 -- read $11 on A and B
		 s_WE	          <= '0';
	    	 s_RST    	  <= '0';
	    	 s_srcA   	  <= "01011";
 	    	 s_srcB    	  <= "01011";
	    	 s_dstReg 	  <= "00000"; 
	    	 s_imm     	  <= X"0000";
	    	 s_immSelect      <= '0';
	    	 s_shiftAmount    <= "00000";
	    	 s_ALUCONTROL     <= "0000";
	   	 s_mem2reg 	  <= '0';
	    	 s_dataMemoryWE   <= '0';
	   	 s_extensionMode  <= '0';
		 s_ExpectedValue  <= X"00000000";
		 wait for cCLK_PER;






		
    wait;
  end process;
  
end behavior;