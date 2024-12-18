-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_addersubtractor_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the addersubtractor_N unit.
--              
-- 09/26/2024 by Kaden::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_addersubtractor_N is
end entity tb_addersubtractor_N;

architecture behavior of tb_addersubtractor_N is
--components, signals, component instances


constant N : integer := 32;

component addersubtractor_N is
generic(N : integer := 32);
	port(A : in std_logic_vector(N-1 downto 0);
	     B : in std_logic_vector(N-1 downto 0);
	     nAdd_Sub : in std_logic;
             Sum : out std_logic_vector(N-1 downto 0);
	     Overflow : out std_logic);
end component;
	
--signals
signal s_A, s_B, s_S : std_logic_vector(N-1 downto 0);
signal s_nAdd_Sub, s_Overflow : std_logic;

begin

-- instantiate design

DUT0: addersubtractor_N
port map(A => s_A,
	 B => s_B,
	 nAdd_Sub => s_nAdd_Sub,
	 Sum => s_S,
	 Overflow => s_Overflow);

-- test sequence

process
	begin
	
	s_A  	   <= X"FFFFFFFF";
	s_B        <= X"FFFFFFFF";
	s_nAdd_Sub <= '1';
	wait for 10 ns;

	s_A  	   <= X"FFFFFFFF";
	s_B        <= X"00000000";
	s_nAdd_Sub <= '1';
	wait for 10 ns;



	end process;
end architecture;