-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the barrel_shifter unit
--              
-- 10/13/2024 by KAB::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_barrel_shifter is
end entity tb_barrel_shifter;

architecture behavior of tb_barrel_shifter is
--components, signals, component instances
component barrel_shifter is
    port(input 	      : in std_logic_vector(31 downto 0);
	 shift_Direction : in std_logic; -- 0 for left, 1 for right
	 shift_Amount : in std_logic_vector(4 downto 0);
	 shift_Type   : in std_logic; -- 0 for logical, 1 for arithmetic
	 output	      : out std_logic_vector(31 downto 0));
end component;

	
--signals
signal s_shift_Type, s_shift_Direction : sztd_logic;
signal s_shift_Amount : std_logic_vector(4 downto 0);
signal s_Input, s_Output : std_logic_vector(31 downto 0);

begin

-- instantiate design

DUT0: barrel_shifter
port map(input 	    	  => s_Input,
	 shift_Direction  => s_shift_Direction,
	 shift_Amount 	  => s_shift_Amount,
	 shift_Type    	  => s_shift_Type,
	 output	     	  => s_Output);

-- test sequence

process
	begin
	
	-- Test Right Shift
	s_Input 	  <= X"80000000"; 
	s_shift_Direction <= '0';
 	s_shift_Type      <= '0';
 	s_shift_Amount 	  <= "00001"; 
	wait for 20 ns;

	-- Test Right Max Shift
	s_Input 	  <= X"80000000"; 
	s_shift_Direction <= '0';
 	s_shift_Type      <= '0';
 	s_shift_Amount 	  <= "11111"; 
	wait for 20 ns;

	-- Test Right Arithmetic Shift
	s_Input 	  <= X"80000000"; 
	s_shift_Direction <= '0';
 	s_shift_Type      <= '1';
 	s_shift_Amount 	  <= "00001"; 
	wait for 20 ns;

	-- Test Right Max Arithmetic Shift
	s_Input 	  <= X"80000000"; 
	s_shift_Direction <= '0';
 	s_shift_Type      <= '1';
 	s_shift_Amount 	  <= "11111"; 
	wait for 20 ns;

	-- Test Left Shift
	s_Input 	  <= X"00000001"; 
	s_shift_Direction <= '1';
 	s_shift_Type      <= '0';
 	s_shift_Amount 	  <= "00001"; 
	wait for 20 ns;

	-- Test Left Max Shift
	s_Input 	  <= X"00000001"; 
	s_shift_Direction <= '1';
 	s_shift_Type      <= '0';
 	s_shift_Amount 	  <= "11111"; 
	wait for 20 ns;


	end process;
end architecture;