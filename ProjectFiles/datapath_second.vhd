-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- datapath_second.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the second datapath
-- NOTES:
-- 9/29/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


-- Entity
entity datapath_second is
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

end datapath_second;

-- Architecture
architecture structural of datapath_second is

--Signal Declaration
signal regAOutput, regBOutput, adderOutput, signExtenderOutput, dmemDataOut, mem2RegOutput : std_logic_vector(31 downto 0);
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

component addersubtractor_N is
generic(N : integer := 32);
	port(A : in std_logic_vector(N-1 downto 0);
	     B : in std_logic_vector(N-1 downto 0);
	     imm: in std_logic_vector(N-1 downto 0);
	     ALUSrc : in std_logic;
	     nAdd_Sub : in std_logic;
             Sum : out std_logic_vector(N-1 downto 0);
	     Cout : out std_logic);
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
	
	register_file_part1 : register_file
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

	adder : addersubtractor_N
	port map(A        => regAOutput,
	     	 B        => regBOutput,
	     	 imm      => signExtenderOutput,
	     	 ALUSrc   => i_ALUSrc,
	     	 nAdd_Sub => i_nAdd_Sub,
             	 Sum      => adderOutput);
	     	 --Cout     

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

	register_file_part2 : register_file
	port map(regfile_writeEnable => i_WE,
	     	 regfile_CLK  	     => i_CLK,
	     	 regfile_RST 	     => i_RST,
	     	 data_In	     => mem2RegOutput,
	     	 srcA		     => i_srcA,
	     	 srcB		     => i_srcB,
	     	 dstReg		     => i_destReg,
	     	 readA		     => o_readA,
	     	 readB		     => o_readB);


	
end architecture structural;