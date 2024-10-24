-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_zero_FlagCheck.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the replqb unit.
--              
-- 10/17/2024 by Kaden::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_zero_FlagCheck is
end entity tb_zero_FlagCheck;

architecture behavior of tb_zero_FlagCheck is
--components, signals, component instances

component zero_FlagCheck is
  port(i_A          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic);
end component;
	
--signals
signal s_Input : std_logic_vector(31 downto 0);
signal s_Result, s_Result_Expected : std_logic;

begin

-- instantiate design

DUT0: zero_FlagCheck
port map(i_A => s_Input,
	 o_F => s_Result);
-- test sequence

process
	begin
	
	s_Input           <= X"00000000";
	s_Result_Expected <= '1';
	wait for 10 ns;

	s_Input           <= X"00000001";
	s_Result_Expected <= '0';
	wait for 10 ns;

	s_Input           <= X"FFFFFFFF";
	s_Result_Expected <= '0';
	wait for 10 ns;

	end process;
end architecture;