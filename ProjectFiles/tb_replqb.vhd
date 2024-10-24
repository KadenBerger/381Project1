-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_replqb.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the replqb unit.
--              
-- 10/17/2024 by Kaden::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_replqb is
end entity tb_replqb;

architecture behavior of tb_replqb is
--components, signals, component instances
component replqb is
  port(input          : in std_logic_vector(31 downto 0);
       byte_Select    : in std_logic_vector(1 downto 0);
       o_F            : out std_logic_vector(31 downto 0));
end component;
	
--signals
signal s_Input,s_Result : std_logic_vector(31 downto 0);
signal s_byte_Select : std_logic_vector(1 downto 0);

begin

-- instantiate design

DUT0: replqb
port map(input       => s_Input,
         byte_Select => s_byte_Select,
         o_F         => s_Result);

-- test sequence

process
	begin
	
	s_Input       <= X"000000FF";
	s_byte_Select <= "00";
	wait for 10 ns;

	s_Input       <= X"0000FF00";
	s_byte_Select <= "01";
	wait for 10 ns;

	s_Input       <= X"00FF0000";
	s_byte_Select <= "10";
	wait for 10 ns;

	s_Input       <= X"FF000000";
	s_byte_Select <= "11";
	wait for 10 ns;

	s_Input       <= X"000000EE";
	s_byte_Select <= "00";
	wait for 10 ns;

	s_Input       <= X"00002200";
	s_byte_Select <= "01";
	wait for 10 ns;

	s_Input       <= X"00330000";
	s_byte_Select <= "10";
	wait for 10 ns;

	s_Input       <= X"44000000";
	s_byte_Select <= "11";
	wait for 10 ns;


	end process;
end architecture;