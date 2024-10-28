-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- register_file.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a register file
-- NOTES:
-- 9/26/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


-- Entity

entity register_file is
	port(regfile_writeEnable: in std_logic;
	     regfile_CLK : in std_logic;
	     regfile_RST : in std_logic;
	     data_In: in std_logic_vector(31 downto 0);
	     srcA: in std_logic_vector(4 downto 0);
	     srcB: in std_logic_vector(4 downto 0);
	     dstReg : in std_logic_vector(4 downto 0);
	     readA: out std_logic_vector(31 downto 0);
	     readB: out std_logic_vector(31 downto 0));
end register_file;

-- Architecture
architecture structural of register_file is

--Signal Declaration

signal s_decoderOut: std_logic_vector(31 downto 0);

type register_array is array (0 to 31) of std_logic_vector(31 downto 0);
signal s_register_array : register_array;

-- Component declarations
component register_Nbit is
generic(N : integer := 32);
	port(clock: in std_logic;
	     reset: in std_logic;
	     writeEnable: in std_logic;
	     dataIn: in std_logic_vector(N-1 downto 0);
	     dataOut: out std_logic_vector(N-1 downto 0));
end component;

component decoder_5to32 is
	port(enable : in std_logic;
	decoderIn	: in std_logic_vector(4 downto 0);
	decoderOut	: out std_logic_vector(31 downto 0));
end component;

component multiplexer_32to1 is
    port(
        input0 : in std_logic_vector(31 downto 0);
        input1 : in std_logic_vector(31 downto 0);
        input2 : in std_logic_vector(31 downto 0);
        input3 : in std_logic_vector(31 downto 0);
        input4 : in std_logic_vector(31 downto 0);
        input5 : in std_logic_vector(31 downto 0);
        input6 : in std_logic_vector(31 downto 0);
        input7 : in std_logic_vector(31 downto 0);
        input8 : in std_logic_vector(31 downto 0);
        input9 : in std_logic_vector(31 downto 0);
        input10 : in std_logic_vector(31 downto 0);
        input11 : in std_logic_vector(31 downto 0);
        input12 : in std_logic_vector(31 downto 0);
        input13 : in std_logic_vector(31 downto 0);
        input14 : in std_logic_vector(31 downto 0);
        input15 : in std_logic_vector(31 downto 0);
        input16 : in std_logic_vector(31 downto 0);
        input17 : in std_logic_vector(31 downto 0);
        input18 : in std_logic_vector(31 downto 0);
        input19 : in std_logic_vector(31 downto 0);
        input20 : in std_logic_vector(31 downto 0);
        input21 : in std_logic_vector(31 downto 0);
        input22 : in std_logic_vector(31 downto 0);
        input23 : in std_logic_vector(31 downto 0);
        input24 : in std_logic_vector(31 downto 0);
        input25 : in std_logic_vector(31 downto 0);
        input26 : in std_logic_vector(31 downto 0);
        input27 : in std_logic_vector(31 downto 0);
        input28 : in std_logic_vector(31 downto 0);
        input29 : in std_logic_vector(31 downto 0);
        input30 : in std_logic_vector(31 downto 0);
        input31 : in std_logic_vector(31 downto 0);
        sel    : in std_logic_vector(4 downto 0);
        output : out std_logic_vector(31 downto 0));
end component;


-- Logic
	begin
	

	-- decoder instantiation
	decoder : decoder_5to32 port map(
	   enable => regfile_writeEnable,
	decoderIn => dstReg,
       decoderOut => s_decoderOut);



	-- register instantiation
	registers : for i in 0 to 31 generate
	register_I : register_Nbit 

	port map(clock => regfile_CLK,
		reset => regfile_RST,
	  writeEnable => s_decoderOut(i),
	       dataIn => data_In,
	      dataOut => s_register_array(i));
	end generate;

	mux_A : multiplexer_32to1
	port map(
        input0   => X"00000000",
        input1   => s_register_array(1),
        input2   => s_register_array(2),
        input3   => s_register_array(3),
        input4   => s_register_array(4),
        input5   => s_register_array(5),
        input6   => s_register_array(6),
        input7   => s_register_array(7),
        input8   => s_register_array(8),
        input9   => s_register_array(9),
        input10  => s_register_array(10),
        input11  => s_register_array(11),
        input12  => s_register_array(12),
        input13  => s_register_array(13),
        input14  => s_register_array(14),
        input15  => s_register_array(15),
        input16  => s_register_array(16),
        input17  => s_register_array(17),
        input18  => s_register_array(18),
        input19  => s_register_array(19),
        input20  => s_register_array(20),
        input21  => s_register_array(21),
        input22  => s_register_array(22),
        input23  => s_register_array(23),
        input24  => s_register_array(24),
        input25  => s_register_array(25),
        input26  => s_register_array(26),
        input27  => s_register_array(27),
        input28  => s_register_array(28),
        input29  => s_register_array(29),
        input30  => s_register_array(30),
        input31  => s_register_array(31),
        sel      => srcA,
        output   => readA);

	mux_B : multiplexer_32to1
	port map(
        input0   => X"00000000",
        input1   => s_register_array(1),
        input2   => s_register_array(2),
        input3   => s_register_array(3),
        input4   => s_register_array(4),
        input5   => s_register_array(5),
        input6   => s_register_array(6),
        input7   => s_register_array(7),
        input8   => s_register_array(8),
        input9   => s_register_array(9),
        input10  => s_register_array(10),
        input11  => s_register_array(11),
        input12  => s_register_array(12),
        input13  => s_register_array(13),
        input14  => s_register_array(14),
        input15  => s_register_array(15),
        input16  => s_register_array(16),
        input17  => s_register_array(17),
        input18  => s_register_array(18),
        input19  => s_register_array(19),
        input20  => s_register_array(20),
        input21  => s_register_array(21),
        input22  => s_register_array(22),
        input23  => s_register_array(23),
        input24  => s_register_array(24),
        input25  => s_register_array(25),
        input26  => s_register_array(26),
        input27  => s_register_array(27),
        input28  => s_register_array(28),
        input29  => s_register_array(29),
        input30  => s_register_array(30),
        input31  => s_register_array(31),
        sel      => srcB,
        output   => readB);
	
end architecture structural;
