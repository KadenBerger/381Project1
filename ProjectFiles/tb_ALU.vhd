-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_ALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the ALU unit.
--              
-- 10/14/2024 by KAB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ALU is
end entity tb_ALU;

architecture behavior of tb_ALU is
--components, signals, component instances

component ALU is
    port(input_A 	    : in std_logic_vector(31 downto 0);
	 input_B 	    : in std_logic_vector(31 downto 0);
	 shift_AmountOrByte : in std_logic_vector(4 downto 0);
	 ALUCONTROL 	    : in std_logic_vector(3 downto 0);
	 zero_Flag	    : out std_logic;
	 overflow_Flag	    : out std_logic;
	 carry_Out	    : out std_logic;
	 result	     	    : out std_logic_vector(31 downto 0));
end component;
	
--signals
signal s_A, s_B, s_result  : std_logic_vector(31 downto 0);
signal s_ShiftAmountOrByte : std_logic_vector(4 downto 0);
signal s_ALUOP		   : std_logic_vector(3 downto 0);
signal s_zero_Flag, s_overflow_Flag, s_carry_Out : std_logic;
signal s_result_Expected   : std_logic_vector(31 downto 0);

begin

-- instantiate design

DUT0: ALU
port map(input_A 	    => s_A,
	 input_B 	    => s_B,
	 shift_AmountOrByte => s_ShiftAmountOrByte,
	 ALUCONTROL 	    => s_ALUOP,
	 zero_Flag	    => s_zero_Flag,
	 overflow_Flag	    => s_overflow_Flag,
	 carry_Out	    => s_carry_Out,
	 result	     	    => s_result);

-- test sequence
process
	begin
	
	-- Adder Tests

	-- add
	s_A  	            <= X"FFFFFFFF";
	s_B                 <= X"00000000";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	            <= "1100";
	s_result_Expected   <= X"FFFFFFFF";
	wait for 20 ns;
	
	-- add with carryout 
	s_A  	            <= X"FFFFFFFF";
	s_B                 <= X"00000001";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	            <= "1100";
	s_result_Expected   <= X"00000000";
	wait for 20 ns;

	-- add with overflow
	s_A  	            <= X"7FFFFFFF";
	s_B                 <= X"00000001";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	            <= "1100";
	s_result_Expected   <= X"80000000";
	wait for 20 ns;

	-- addu
	s_A  	            <= X"FFFFFFFF";
	s_B                 <= X"00000000";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	            <= "0010";
	s_result_Expected   <= X"FFFFFFFF";
	wait for 20 ns;

	-- sub
	s_A  	   	    <= X"FFFFFFFF";
	s_B           	    <= X"FFFFFFFF";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	     	    <= "1101";
	s_result_Expected   <= X"00000000";
	wait for 20 ns;

	-- sub with overflow
	s_A  	   	    <= X"80000000";
	s_B           	    <= X"00000001";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	     	    <= "1101";
	s_result_Expected   <= X"7FFFFFFF";
	wait for 20 ns;

	-- subu
	s_A  	    	    <= X"FFFFFFFF";
	s_B         	    <= X"FFFFFFFF";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	    	    <= "0011";
	s_result_Expected   <= X"00000000";
	wait for 20 ns;

	-- Shifter Tests

	-- sll max
	s_A  	     	    <= X"00000000";
	s_B          	    <= X"00000001";
	s_ShiftAmountOrByte <= "11111";
	s_ALUOP	     	    <= "0101";
	s_result_Expected   <= X"80000000";
	wait for 20 ns;

	-- sll test
	s_A  	     	    <= X"00000000";
	s_B          	    <= X"00007FFF";
	s_ShiftAmountOrByte <= "00100";
	s_ALUOP	     	    <= "0101";
	s_result_Expected   <= X"7FFF0000";
	wait for 20 ns;
	
	-- srl max
	s_A  	     	    <= X"00000000";
	s_B          	    <= X"80000000";
	s_ShiftAmountOrByte <= "11111";
	s_ALUOP	      	    <= "0100";
	s_result_Expected   <= X"00000001";
	wait for 20 ns;

	-- sra max
	s_A  	   	    <= X"00000000";
	s_B          	    <= X"80000000";
	s_ShiftAmountOrByte <= "11111";
	s_ALUOP	      	    <= "0110";
	s_result_Expected   <= X"FFFFFFFF";
	wait for 20 ns;

	-- Boolean Logic Tests

	-- and
	s_A  	     	    <= X"11110100";
	s_B          	    <= X"11110001";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	     	    <= "0111";
	s_result_Expected   <= X"11110000";
	wait for 20 ns;

	-- or
	s_A  	    	    <= X"11110100";
	s_B         	    <= X"11110001";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	     	    <= "1000";
	s_result_Expected   <= X"11110101";
	wait for 20 ns;

	-- xor
	s_A  	   	    <= X"11110100";
	s_B         	    <= X"11110001";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	     	    <= "1001";
	s_result_Expected   <= X"00000101";
	wait for 20 ns;

	-- nor
	s_A  	    	    <= X"11110100";
	s_B          	    <= X"11110001";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	     	    <= "1010";
	s_result_Expected   <= X"EEEEFEFE";
	wait for 20 ns;

	-- Set Less Than Tests

	-- slt
	s_A  	     	    <= X"00000002";
	s_B         	    <= X"00000005";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	     	    <= "1011";
	s_result_Expected   <= X"00000001";
	wait for 20 ns;

	-- slt
	s_A  	    	    <= X"00000005";
	s_B          	    <= X"00000002";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	    	    <= "1011";
	s_result_Expected   <= X"00000000";
	wait for 20 ns;

	-- slt
	s_A  	    	    <= X"FFFFFFFD";
	s_B          	    <= X"FFFFFFFE";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	     	    <= "1011";
	s_result_Expected   <= X"00000001";
	wait for 20 ns;

	-- replqb
	s_A  	    	    <= X"000000EE";
	s_B         	    <= X"00000000";
	s_ShiftAmountOrByte <= "00000";
	s_ALUOP	    	    <= "1111";
	s_result_Expected   <= X"EEEEEEEE";
	wait for 20 ns;
	
	end process;
end architecture;