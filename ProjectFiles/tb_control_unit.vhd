-------------------------------------------------------------------------
-- tb_control_unit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the MIPS control unit
-- this will be testing different opcodes and function values.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
use IEEE.numeric_std.all;	-- For to_usnigned
library std;
use std.textio.all;             -- For basic I/O

entity tb_control_unit is
  generic(gCLK_HPER   : time := 50 ns); --half period clock
end tb_control_unit;

architecture behavior of tb_control_unit is
  
constant cCLK_PER  : time := gCLK_HPER * 2; --full period clock

component control_unit

	port(i_opcode  	  	: in std_logic_vector(5 downto 0); --input
	     i_funct	  	: in std_logic_vector(5 downto 0); --input
	     o_ctrl_unit	: out std_logic_vector(14 downto 0)); --output
end component;

-- Temporary signals to connect to the dff component.
signal s_CLK : std_logic := '0';
signal s_opcode    : std_logic_vector(5 downto 0) := (others => '0'); --opcode input
signal s_funct     : std_logic_vector(5 downto 0) := (others => '0'); --funct input
signal s_ctrl_unit  : std_logic_vector(14 downto 0); -- control signal output
signal expected_output: std_logic_vector(14 downto 0):= (others => '0'); -- expected output

begin

DUT: control_unit -- the DUT
port map(i_opcode => s_opcode,
           i_funct => s_funct,
           o_ctrl_unit => s_ctrl_unit);

P_CLK: process --Alternate the clock signal

begin

s_CLK <= '0';

wait for gCLK_HPER;

s_CLK <= '1';

wait for gCLK_HPER/2;

end process;
  
-- This is the main test process for the control unit
P_TB: process

begin

-- test add instruction
s_opcode <= "000000";
s_funct  <= "100000";
expected_output <= "000111000110100";

wait for cCLK_PER/2;

-- test addu instruction
s_opcode <= "000000";
s_funct  <= "100001";
expected_output <= "000000000110100";

wait for cCLK_PER/2;

-- test and instruction
s_opcode <= "000000";
s_funct  <= "100100";
expected_output <= "000001000110100";

wait for cCLK_PER/2;

-- test nor instruction
s_opcode <= "000000";
s_funct  <= "100111";
expected_output <= "000010100110100";

wait for cCLK_PER/2;

-- test xor instruction
s_opcode <= "000000";
s_funct  <= "100110";
expected_output <= "000010000110100";

wait for cCLK_PER/2;

-- test or instruction
s_opcode <= "000000";
s_funct  <= "100101";
expected_output <= "000001100110100";

wait for cCLK_PER/2;

-- test slt instruction
s_opcode <= "000000";
s_funct  <= "101010";
expected_output <= "000011100110100";

wait for cCLK_PER/2;

-- test sll instruction
s_opcode <= "000000";
s_funct  <= "000000";
expected_output <= "000100100110100";

wait for cCLK_PER/2;

-- test srl instruction
s_opcode <= "000000";
s_funct  <= "000010";
expected_output <= "000100000110000";

wait for cCLK_PER/2;

-- test sra instruction
s_opcode <= "000000";
s_funct  <= "000011";
expected_output <= "000101000110100";

wait for cCLK_PER/2;

-- test sub instruction
s_opcode <= "000000";
s_funct  <= "100010";
expected_output <= "000111100110100";

wait for cCLK_PER/2;

-- test subu instruction
s_opcode <= "000000";
s_funct  <= "100011";
expected_output <= "000000100110100";

wait for cCLK_PER/2;

-- test addi instruction
s_opcode <= "001000";
s_funct  <= "000000";
expected_output <= "001111000100100";

wait for cCLK_PER/2;

-- test addiu instruction
s_opcode <= "001001";
expected_output <= "001000000100100";

wait for cCLK_PER/2;

-- test andi instruction
s_opcode <= "001100";
expected_output <= "001001000100000";

wait for cCLK_PER/2;

-- test xori instruction
s_opcode <= "001110";
expected_output <= "001010000100000";

wait for cCLK_PER/2;

-- test ori instruction
s_opcode <= "001101";
expected_output <= "001001100100000";

wait for cCLK_PER/2;

-- test slti instruction
s_opcode <= "001010";
expected_output <= "001011100100100";

wait for cCLK_PER/2;

-- test lui instruction
s_opcode <= "001111";
expected_output <= "001011000100100";

wait for cCLK_PER/2;

-- test beq instruction
s_opcode <= "000100";
expected_output <= "000101100001100";

wait for cCLK_PER/2;

-- test bne instruction
s_opcode <= "000101";
expected_output <= "000110000001100";

wait for cCLK_PER/2;

-- test lw instruction
s_opcode <= "100011";
expected_output <= "001000010100100";

    wait for cCLK_PER/2;
-- test sw instruction
s_opcode <= "101011";
expected_output <= "001000001000100";
wait for cCLK_PER/2;

-- test j instruction
s_opcode <= "000010";
expected_output <= "000000000000110";

wait for cCLK_PER/2;

-- test jal instruction
s_opcode <= "000011";
expected_output <= "010000000100110";

wait for cCLK_PER/2;

-- test jr instruction
s_opcode <= "000000";
s_funct  <= "001000";
expected_output <= "100000000000110";

wait for cCLK_PER/2;

-- test halt instruction
s_opcode <= "010100";
s_funct  <= "000000";
expected_output <= "000000000000001";

wait for cCLK_PER/2;

wait;

end process;
  
end behavior;