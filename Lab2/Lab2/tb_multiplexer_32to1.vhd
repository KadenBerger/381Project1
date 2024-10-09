-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_multiplexer_32to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an testbench for the 32 to 1 multiplexer component 
--
--
--
-- NOTES:
-- 9/25/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_multiplexer_32to1 is
end entity tb_multiplexer_32to1;

architecture behavior of tb_multiplexer_32to1 is
--components, signals, component instances

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

	

signal s_sel : std_logic_vector(4 downto 0); 
signal s_output : std_logic_vector(31 downto 0);
signal s_input0, s_input1, s_input2  : std_logic_vector(31 downto 0);
signal  s_input3,  s_input4,  s_input5,  s_input6  : std_logic_vector(31 downto 0);
signal	s_input7,  s_input8,  s_input9,  s_input10  : std_logic_vector(31 downto 0);
signal	s_input11,  s_input12,  s_input13,  s_input14  : std_logic_vector(31 downto 0);
signal	s_input15,  s_input16,  s_input17,  s_input18  : std_logic_vector(31 downto 0);
signal	s_input19,  s_input20,  s_input21,  s_input22  : std_logic_vector(31 downto 0);  
signal	s_input23,  s_input24,  s_input25,  s_input26  : std_logic_vector(31 downto 0); 
signal	s_input27,  s_input28,  s_input29,  s_input30,  s_input31  : std_logic_vector(31 downto 0);

begin

-- instantiate design

DUT0: multiplexer_32to1
port map(sel => s_sel,
	 output => s_output,
	input0 => s_input0,
	input1 => s_input1,
	input2 => s_input2,
	input3 => s_input3,
	input4 => s_input4,
	input5 => s_input5,
	input6 => s_input6,
	input7 => s_input7,
	input8 => s_input8,
	input9 => s_input9,
	input10 => s_input10,
	input11 => s_input11,
	input12 => s_input12,
	input13 => s_input13,
	input14 => s_input14,
	input15 => s_input15,
	input16 => s_input16,
	input17 => s_input17,
	input18 => s_input18,
	input19 => s_input19,
	input20 => s_input20,
	input21 => s_input21,
	input22 => s_input22,
	input23 => s_input23,
	input24 => s_input24,
	input25 => s_input25,
	input26 => s_input26,
	input27 => s_input27,
	input28 => s_input28,
	input29 => s_input29,
	input30 => s_input30,
	input31 => s_input31);
-- test sequence

process
	begin
	
s_input0 <= X"00000000";  -- 0
s_sel <= "00000"; -- 0
wait for 20 ns;

s_input1 <= X"00000001";  -- 1
s_sel <= "00001"; -- 1
wait for 20 ns;

s_input2 <= X"00000002";  -- 2
s_sel <= "00010"; -- 2
wait for 20 ns;

s_input3 <= X"00000003";  -- 3
s_sel <= "00011"; -- 3
wait for 20 ns;

s_input4 <= X"00000004";  -- 4
s_sel <= "00100"; -- 4
wait for 20 ns;

s_input5 <= X"00000005";  -- 5
s_sel <= "00101"; -- 5
wait for 20 ns;

s_input6 <= X"00000006";  -- 6
s_sel <= "00110"; -- 6
wait for 20 ns;

s_input7 <= X"00000007";  -- 7
s_sel <= "00111"; -- 7
wait for 20 ns;

s_input8 <= X"00000008";  -- 8
s_sel <= "01000"; -- 8
wait for 20 ns;

s_input9 <= X"00000009";  -- 9
s_sel <= "01001"; -- 9
wait for 20 ns;

s_input10 <= X"0000000A";  -- 10
s_sel <= "01010"; -- 10
wait for 20 ns;

s_input11 <= X"0000000B";  -- 11
s_sel <= "01011"; -- 11
wait for 20 ns;

s_input12 <= X"0000000C";  -- 12
s_sel <= "01100"; -- 12
wait for 20 ns;

s_input13 <= X"0000000D";  -- 13
s_sel <= "01101"; -- 13
wait for 20 ns;

s_input14 <= X"0000000E";  -- 14
s_sel <= "01110"; -- 14
wait for 20 ns;

s_input15 <= X"0000000F";  -- 15
s_sel <= "01111"; -- 15
wait for 20 ns;

s_input16 <= X"00000010";  -- 16
s_sel <= "10000"; -- 16
wait for 20 ns;

s_input17 <= X"00000011";  -- 17
s_sel <= "10001"; -- 17
wait for 20 ns;

s_input18 <= X"00000012";  -- 18
s_sel <= "10010"; -- 18
wait for 20 ns;

s_input19 <= X"00000013";  -- 19
s_sel <= "10011"; -- 19
wait for 20 ns;

s_input20 <= X"00000014";  -- 20
s_sel <= "10100"; -- 20
wait for 20 ns;

s_input21 <= X"00000015";  -- 21
s_sel <= "10101"; -- 21
wait for 20 ns;

s_input22 <= X"00000016";  -- 22
s_sel <= "10110"; -- 22
wait for 20 ns;

s_input23 <= X"00000017";  -- 23
s_sel <= "10111"; -- 23
wait for 20 ns;

s_input24 <= X"00000018";  -- 24
s_sel <= "11000"; -- 24
wait for 20 ns;

s_input25 <= X"00000019";  -- 25
s_sel <= "11001"; -- 25
wait for 20 ns;

s_input26 <= X"0000001A";  -- 26
s_sel <= "11010"; -- 26
wait for 20 ns;

s_input27 <= X"0000001B";  -- 27
s_sel <= "11011"; -- 27
wait for 20 ns;

s_input28 <= X"0000001C";  -- 28
s_sel <= "11100"; -- 28
wait for 20 ns;

s_input29 <= X"0000001D";  -- 29
s_sel <= "11101"; -- 29
wait for 20 ns;

s_input30 <= X"0000001E";  -- 30
s_sel <= "11110"; -- 30
wait for 20 ns;

s_input31 <= X"0000001F";  -- 31
s_sel <= "11111"; -- 31
wait for 20 ns;




	end process;
end behavior;