-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- tb_datapath_second.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for the second datapath
-- NOTES:
-- 9/29/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_datapath_second is
  generic(gCLK_HPER   : time := 50 ns);
end tb_datapath_second;

architecture behavior of tb_datapath_second is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer := 32;

  -- Component declaration
component datapath_second is
	port(i_WE : in std_logic;
	     i_CLK     : in std_logic;
	     i_RST     : in std_logic;
	     i_dataIn  : in std_logic_vector(31 downto 0);
	     i_srcA    : in std_logic_vector(4 downto 0);
 	     i_srcB    : in std_logic_vector(4 downto 0);
	     i_destReg : in std_logic_vector(4 downto 0);
	     o_readA   : out std_logic_vector(31 downto 0);
	     o_readB   : out std_logic_vector(31 downto 0);
	     i_imm     : in std_logic_vector(15 downto 0);
	     i_nAdd_Sub: in std_logic;
	     i_ALUSrc  : in std_logic;
	     i_mem2reg  : in std_logic;
	     i_dataMemoryWE  : in std_logic;
	     i_extensionMode  : in std_logic);
end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_RST, s_WE, s_nAdd_Sub, s_ALUSrc,s_mem2reg, s_extensionMode, s_dataMemoryWE : std_logic;
  signal s_data_In, s_readA, s_readB : std_logic_vector(31 downto 0);
  signal s_srcA, s_srcB, s_dstReg : std_logic_vector(4 downto 0);
  signal s_imm : std_logic_vector(15 downto 0);

begin

  DUT: datapath_second
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
    	   i_ALUSrc  => s_ALUSrc,
    	   i_mem2reg  => s_mem2reg,
	   i_dataMemoryWE => s_dataMemoryWE,
    	   i_extensionMode  => s_extensionMode);

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

    -- addi $25, $0, 0
	s_ALUSrc   	 <= '1';
	s_nAdd_Sub 	 <= '0';
	s_RST      	 <= '0';
	s_WE      	 <= '1';
	s_dstReg  	 <= "11001";
	s_srcA    	 <= "00000";
	s_srcB    	 <= "00000";
	s_imm     	 <= X"0000";
	s_mem2reg        <= '0';
	s_dataMemoryWE   <= '0';
	s_extensionMode  <= '0';
	wait for cCLK_PER;

  -- check on both reads that register 25, has a value of 0
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "11001";
	s_srcB     <= "11001";
	s_imm      <= X"0000";
	s_mem2reg        <= '0';
	s_dataMemoryWE   <= '0';
	s_extensionMode  <= '0';
	wait for cCLK_PER;

    -- addi $26, $0, 256
	s_ALUSrc   	 <= '1';
	s_nAdd_Sub 	 <= '0';
	s_RST      	 <= '0';
	s_WE      	 <= '1';
	s_dstReg  	 <= "11010";
	s_srcA    	 <= "00000";
	s_srcB    	 <= "00000";
	s_imm     	 <= X"0100";
	s_mem2reg        <= '0';
	s_dataMemoryWE   <= '0';
	s_extensionMode  <= '0';
	wait for cCLK_PER;

  -- check on both reads that register 26, has a value of 256
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "11010";
	s_srcB     <= "11010";
	s_imm      <= X"0000";
	s_mem2reg        <= '0';
	s_dataMemoryWE   <= '0';
	s_extensionMode  <= '0';
	wait for cCLK_PER;

    -- lw $1, 0($25)
	s_ALUSrc   	 <= '1';
	s_nAdd_Sub 	 <= '0';
	s_RST      	 <= '0';
	s_WE      	 <= '1';
	s_dstReg  	 <= "00001";
	s_srcA    	 <= "11001";
	s_srcB    	 <= "00000";
	s_imm     	 <= X"0000";
	s_mem2reg        <= '1';
	s_dataMemoryWE   <= '0';
	s_extensionMode  <= '0';
	wait for cCLK_PER;

  -- check on both reads that register 1, has a value of -1
	s_ALUSrc   <= '0';
	s_nAdd_Sub <= '0';
	s_RST      <= '0';
	s_WE       <= '0';
	s_dstReg   <= "00000";
	s_srcA     <= "00001";
	s_srcB     <= "00001";
	s_imm      <= X"0000";
	s_mem2reg        <= '0';
	s_dataMemoryWE   <= '0';
	s_extensionMode  <= '0';
	wait for cCLK_PER;

	-- lw $2, 1($25) # Load A[1] into $2
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00010";     -- $2
	s_srcA          <= "11001";     -- $25
	s_srcB          <= "00000";
	s_imm           <= X"0001";   
	s_mem2reg       <= '1';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 2 = 2
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00010";     
	s_srcB          <= "00010";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- add $1, $1, $2 $1 = -1 + 2 = 1
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00001";     -- $1
	s_srcA          <= "00001";     -- $1
	s_srcB          <= "00010";	--#2
	s_imm           <= X"0000";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 1 = 1
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00001";     
	s_srcB          <= "00001";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- sw $1, 0($26) # Store 1 into B[0]
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00000";    
	s_srcA          <= "11010";  
	s_srcB          <= "00001";
	s_imm           <= X"0000";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '1';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	
	-- lw $2, 2($25) # Load A[2] into $2
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00010";     -- $2
	s_srcA          <= "11001";     -- $25
	s_srcB          <= "00000";
	s_imm           <= X"0002";   
	s_mem2reg       <= '1';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 2 = -3
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00010";     
	s_srcB          <= "00010";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- add $1, $1, $2
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00001";     -- $1
	s_srcA          <= "00001";     -- $1
	s_srcB          <= "00010";	--#2
	s_imm           <= X"0000";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 1 = -2
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00001";     
	s_srcB          <= "00001";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- sw $1, 1($26) # Store -2 into B[1]
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00000";    
	s_srcA          <= "11010";  
	s_srcB          <= "00001";
	s_imm           <= X"0001";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '1';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	
	-- lw $2, 3($25) # Load A[3] into $2
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00010";     -- $2
	s_srcA          <= "11001";     -- $25
	s_srcB          <= "00000";
	s_imm           <= X"0003";   
	s_mem2reg       <= '1';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 2 = 4
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00010";     
	s_srcB          <= "00010";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- add $1, $1, $2
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00001";     -- $1
	s_srcA          <= "00001";     -- $1
	s_srcB          <= "00010";	--#2
	s_imm           <= X"0000";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 1 = 2
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00001";     
	s_srcB          <= "00001";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- sw $1, 2($26) # Store 2 into B[2]
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00000";    
	s_srcA          <= "11010";  
	s_srcB          <= "00001";
	s_imm           <= X"0002";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '1';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	
	-- lw $2, 4($25) # Load A[4] into $2
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00010";     -- $2
	s_srcA          <= "11001";     -- $25
	s_srcB          <= "00000";
	s_imm           <= X"0004";   
	s_mem2reg       <= '1';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 2 = 5
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00010";     
	s_srcB          <= "00010";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- add $1, $1, $2
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00001";     -- $1
	s_srcA          <= "00001";     -- $1
	s_srcB          <= "00010";	--#2
	s_imm           <= X"0000";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 1 = 7
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00001";     
	s_srcB          <= "00001";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

-- sw $1, 3($26) # Store 7 into B[3]
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00000";    
	s_srcA          <= "11010";  
	s_srcB          <= "00001";
	s_imm           <= X"0003";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '1';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	
	-- lw $2, 5($25) # Load A[5] into $2
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00010";     -- $2
	s_srcA          <= "11001";     -- $25
	s_srcB          <= "00000";
	s_imm           <= X"0005";   
	s_mem2reg       <= '1';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 2 = 6
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00010";     
	s_srcB          <= "00010";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- add $1, $1, $2
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00001";     -- $1
	s_srcA          <= "00001";     -- $1
	s_srcB          <= "00010";	--#2
	s_imm           <= X"0000";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 1 = 13
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00001";     
	s_srcB          <= "00001";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	--sw $1, 4($26) # Store 13 into B[4]
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00000";    
	s_srcA          <= "11010";  
	s_srcB          <= "00001";
	s_imm           <= X"0004";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '1';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	
	-- lw $2, 6($25) # Load A[6] into $2
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00010";     -- $2
	s_srcA          <= "11001";     -- $25
	s_srcB          <= "00000";
	s_imm           <= X"0006";   
	s_mem2reg       <= '1';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 2 = -7
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00010";     
	s_srcB          <= "00010";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- add $1, $1, $2
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00001";     -- $1
	s_srcA          <= "00001";     -- $1
	s_srcB          <= "00010";	--#2
	s_imm           <= X"0000";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;

	-- register 1 = 6
	s_ALUSrc        <= '0';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '0';
	s_dstReg        <= "00000";     
	s_srcA          <= "00001";     
	s_srcB          <= "00001";
	s_imm           <= X"0000"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;
	
	-- addi $27, $0, 512
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "11011";     
	s_srcA          <= "00000";     
	s_srcB          <= "00000";
	s_imm           <= X"0200"; 
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '0';
	s_extensionMode <= '0' ;
	wait for cCLK_PER;
	
	--sw $1, -1($27) #
	s_ALUSrc        <= '1';
	s_nAdd_Sub      <= '0';
	s_RST           <= '0';
	s_WE            <= '1';
	s_dstReg        <= "00000";    
	s_srcA          <= "11011";  
	s_srcB          <= "00001";
	s_imm           <= X"FFFF";   
	s_mem2reg       <= '0';
	s_dataMemoryWE  <= '1';
	s_extensionMode <= '1' ;
	wait for cCLK_PER;

    wait;
  end process;
  
end behavior;