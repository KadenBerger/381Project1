-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_slt.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the replqb unit.
--              
-- 10/17/2024 by Kaden::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_slt is
end entity tb_slt;

architecture behavior of tb_slt is
--components, signals, component instances
component slt is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;
	
--signals
signal s_Input_A, s_Input_B, s_Result, s_Result_Expected : std_logic_vector(31 downto 0);

begin

-- instantiate design

DUT0: slt
port map(i_A => s_Input_A,
         i_B => s_Input_A,
         o_F => s_Result);

-- test sequence

process
	begin
	
	-- A < B
	s_Input_A 	  <= X"00000002";
	s_Input_B 	  <= X"00000005";
	s_Result_Expected <= X"00000001";
	wait for 10 ns;

	-- A > B
	s_Input_A 	  <= X"00000005";
	s_Input_B 	  <= X"00000002";
	s_Result_Expected <= X"00000000";
	wait for 10 ns;

	-- A > B
	s_Input_A 	  <= X"00000005";
	s_Input_B 	  <= X"00000005";
	s_Result_Expected <= X"00000000";
	wait for 10 ns;

	-- A > B
	s_Input_A 	  <= X"FFFFFFFD";
	s_Input_B 	  <= X"FFFFFFFE";
	s_Result_Expected <= X"00000001";
	wait for 10 ns;


	end process;
end architecture;