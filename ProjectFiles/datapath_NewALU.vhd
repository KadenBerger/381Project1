-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- datapath_NewALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the datapath from
-- lab 2 with the new ALU
-- NOTES:
-- 10/22/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


-- Entity
entity datapath_NewALU is
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

end datapath_NewALU;

-- Architecture
architecture structural of datapath_NewALU is

--Signal Declaration
signal regAOutput, regBOutput, adderOutput, signExtenderOutput, dmemDataOut, mem2RegOutput, immSelectOutput : std_logic_vector(31 downto 0);
signal s_adderSignal : std_logic_vector(31 downto 0);
-- Component declarations

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

component ALU is
    port(input_A 	    : in std_logic_vector(31 downto 0);
	 input_B 	    : in std_logic_vector(31 downto 0);
	 shift_AmountOrByte : in std_logic_vector(4 downto 0);
	 ALUCONTROL 	    : in std_logic_vector(3 downto 0);
	 zero_Flag	    : out std_logic;
	 overflow_Flag	    : out std_logic;
	 carry_Out	    : out std_logic;
	 result	     	    : out std_logic_vector(31 downto 0));
end component;

component sign_extender is
	port(extensionMode   : in std_logic;
	     i_Imm           : in std_logic_vector(15 downto 0);
             o_Extended      : out std_logic_vector(31 downto 0));
end component;

component mux2t1_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

component mem is
	generic(DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10);
	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH-1) downto 0)
	);
end component;



-- Logic
	begin

	register_fileinstance : register_file
	port map(regfile_writeEnable => i_WE,
	     	 regfile_CLK  	     => i_CLK,
	     	 regfile_RST 	     => i_RST,
	     	 data_In	     => mem2RegOutput,
	     	 srcA		     => i_srcA,
	     	 srcB		     => i_srcB,
	     	 dstReg		     => i_destReg,
	     	 readA		     => regAOutput,
	     	 readB		     => regBOutput);

	immediateExtender : sign_extender
	port map(extensionMode => i_extensionMode,
		 i_Imm 	       => i_imm,  -- lowercase i_imm is the input to the datapath
		 o_Extended    => signExtenderOutput);
	
	immediateOrRegisterB : mux2t1_N
	port map(i_S  => i_immSelect,
      		 i_D0 => regBOutput,
      		 i_D1 => signExtenderOutput,
      		 o_O  => immSelectOutput);

	ALUunit : ALU
	port map(input_A 	    => regAOutput,
		 input_B 	    => immSelectOutput,
		 shift_AmountOrByte => i_ShiftAmount,
		 ALUCONTROL 	    => i_ALUCONTROL,
		 zero_Flag	    => flag_Zero,
		 overflow_Flag	    => flag_Overflow,
		-- carry_Out	    =>
		 result	     	    => adderOutput);

	dmem : mem  --mem load -infile dmem.hex -format hex /tb_datapath_second/DUT/DMEM/ram
	port map(clk  => i_CLK,
		 addr => adderOutput(9 downto 0),
		 data => regBOutput,
		 we   => i_dataMemoryWE,
		 q    => dmemDataOut);

	adderOrDataMemoryMux : mux2t1_N
	port map(i_S  => i_mem2reg,
      		 i_D0 => adderOutput,
      		 i_D1 => dmemDataOut,
      		 o_O  => mem2RegOutput);

--	register_file_part2 : register_file
	--port map(regfile_writeEnable => i_WE,
	  --   	 regfile_CLK  	     => i_CLK,
	--     	 regfile_RST 	     => i_RST,
	   --  	 data_In	     => mem2RegOutput,
	  --   	 srcA		     => i_srcA,
	  --   	 srcB		     => i_srcB,
	  --   	 dstReg		     => i_destReg,
	   --  	 readA		     => o_readA,
	--     	 readB		     => o_readB);


	
end architecture structural;