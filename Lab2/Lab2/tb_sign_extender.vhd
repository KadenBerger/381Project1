-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_sign_extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the addersubtractor_N unit.
--              
-- 09/28/2024 by Kaden::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_sign_extender is
end entity tb_sign_extender;

architecture behavior of tb_sign_extender is
--components, signals, component instances
component sign_extender is
	port(extensionMode   : in std_logic;
	     i_Imm            : in std_logic_vector(15 downto 0);
             o_Extended       : out std_logic_vector(31 downto 0));
end component;
	
--signals
signal s_extensionMode : std_logic;
signal s_Imm : std_logic_vector(15 downto 0);
signal s_Output : std_logic_vector(31 downto 0);

begin

-- instantiate design

DUT0: sign_extender
port map(extensionMode   => s_extensionMode,
	 i_Imm           => s_Imm,
	 o_Extended      => s_Output);

-- test sequence

process
	begin
	
s_extensionMode <= '0'; 
s_Imm           <= X"1234";  
wait for 10 ns;

s_extensionMode <= '0';
s_Imm           <= X"0000";
wait for 10 ns;

s_extensionMode <= '0'; 
s_Imm           <= X"7FFF";  
wait for 10 ns;

s_extensionMode <= '1';  
s_Imm           <= X"FFAB";  
wait for 10 ns;

s_extensionMode <= '1';  
s_Imm           <= X"0034";  -- 
wait for 10 ns;

s_extensionMode <= '1';  
s_Imm           <= X"8000";  
wait for 10 ns;

s_extensionMode <= '1';  
s_Imm           <= X"0000"; 
wait for 10 ns;

s_extensionMode <= '0';  
s_Imm           <= X"8A3B"; 
wait for 10 ns;

	end process;
end architecture;