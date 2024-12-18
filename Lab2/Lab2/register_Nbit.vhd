-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- register_Nbit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit register using d-flip flops.
--
--
-- NOTES:
-- 9/18/24 by Kaden::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity register_Nbit is
generic(N : integer := 32);
	port(clock: in std_logic;
	     reset: in std_logic;
	     writeEnable: in std_logic;
	     dataIn: in std_logic_vector(N-1 downto 0);
	     dataOut: out std_logic_vector(N-1 downto 0));
end register_Nbit;

architecture structural of register_Nbit is

component dffg is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin

 G_NBit_Register: for i in 0 to N-1 generate
	dff_inst: dffg
	port map(i_CLK=> clock,
		 i_RST=> reset,
		 i_WE=> writeEnable,
		 i_D=> dataIn(i),
		 o_Q=> dataOut(i));
end generate;

end architecture structural;