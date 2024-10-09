-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_decoder_5to32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an testbench for the 5 to 32 decoder component 
--
--
--
-- NOTES:
-- 9/25/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_decoder_5to32 is
end entity tb_decoder_5to32;

architecture behavior of tb_decoder_5to32 is
--components, signals, component instances

component decoder_5to32 is
	port(enable : in std_logic;
	decoderIn	: in std_logic_vector(4 downto 0);
	decoderOut	: out std_logic_vector(31 downto 0));
end component;
	
signal s_enable : std_logic;
signal s_decoderIn : std_logic_vector(4 downto 0); 
signal s_decoderOut : std_logic_vector(31 downto 0);

begin

-- instantiate design

DUT0: decoder_5to32
port map(enable => s_enable,
	 decoderIn => s_decoderIn,
	 decoderOut => s_decoderOut);
-- test sequence

process
	begin
	
s_enable <= '1';
s_decoderIn <= "00000"; -- 0
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "00001"; -- 1
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "00010"; -- 2
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "00011"; -- 3
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "00100"; -- 4
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "00101"; -- 5
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "00110"; -- 6
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "00111"; -- 7
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "01000"; -- 8
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "01001"; -- 9
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "01010"; -- 10
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "01011"; -- 11
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "01100"; -- 12
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "01101"; -- 13
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "01110"; -- 14
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "01111"; -- 15
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "10000"; -- 16
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "10001"; -- 17
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "10010"; -- 18
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "10011"; -- 19
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "10100"; -- 20
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "10101"; -- 21
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "10110"; -- 22
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "10111"; -- 23
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "11000"; -- 24
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "11001"; -- 25
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "11010"; -- 26
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "11011"; -- 27
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "11100"; -- 28
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "11101"; -- 29
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "11110"; -- 30
wait for 20 ns;

s_enable <= '1';
s_decoderIn <= "11111"; -- 31
wait for 20 ns;




end process;
end behavior;