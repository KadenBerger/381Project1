-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- datapath_first.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the first datapath
-- NOTES:
-- 9/26/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


-- Entity
entity datapath_first is
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

end datapath_first;

-- Architecture
architecture structural of datapath_first is

--Signal Declaration
signal regAOutput, regBOutput, adderOutput : std_logic_vector(31 downto 0);
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



-- Logic
	begin
	
	register_file_part1 : register_file
	port map(regfile_writeEnable => i_WE,
	     	 regfile_CLK  	     => i_CLK,
	     	 regfile_RST 	     => i_RST,
	     	 data_In	     => adderOutput,
	     	 srcA		     => i_srcA,
	     	 srcB		     => i_srcB,
	     	 dstReg		     => i_destReg,
	     	 readA		     => regAOutput,
	     	 readB		     => regBOutput);

	adder : addersubtractor_N
	port map(A        => regAOutput,
	     	 B        => regBOutput,
	     	 imm      => i_imm,
	     	 ALUSrc   => i_ALUSrc,
	     	 nAdd_Sub => i_nAdd_Sub,
             	 Sum      => adderOutput);
	     	 --Cout     

	register_file_part2 : register_file
	port map(regfile_writeEnable => i_WE,
	     	 regfile_CLK  	     => i_CLK,
	     	 regfile_RST 	     => i_RST,
	     	 data_In	     => adderOutput,
	     	 srcA		     => i_srcA,
	     	 srcB		     => i_srcB,
	     	 dstReg		     => i_destReg,
	     	 readA		     => o_readA,
	     	 readB		     => o_readB);


	
end architecture structural;