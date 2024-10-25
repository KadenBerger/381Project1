-- control_unit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the control unit
-- for the MIPS single cycle processor. It is responsible for generating
-- the control signals.
-------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

--Entity declaration 
entity control_unit is

port(
i_opcode : in std_logic_vector(5 downto 0); --input
i_funct : in std_logic_vector(5 downto 0); --input
o_ctrl_unit : out std_logic_vector(14 downto 0) --output
);

end control_unit;

--Architecture of the control unit

architecture dataflow of control_unit is

signal s_rtype : std_logic_vector(14 downto 0); --intermediate signal for rtypes

begin

with i_funct select s_rtype <=

    "000111000110100"  when "100000", -- add enabled in ALU
    "000000000110100"  when "100001", -- addu enabled in ALU
    "000001000110100"  when "100100", -- and enabled in ALU
    "000010100110100"  when "100111", -- nor enabled in ALU
    "000010000110100"  when "100110", -- xor enabled in ALU
    "000001100110100"  when "100101", -- or enabled in ALU
    "000011100110100"  when "101010", -- slt set less than 
    "000011100110100"  when "101011", -- sltu set less than unsigned
    "000100100110100"  when "000000", -- sll shift left logical
    "000100000110000"  when "000010", -- srl shift right logical
    "000101000110100"  when "000011", -- sra shift right arithmetic
    "000111100110100"  when "100010", -- sub enabled in ALU
    "000000100110100"  when "100011", -- subu enabled in ALU
    "100000000000110"  when "001000", -- jr jump reg
    "000000000000000"  when others;

with i_opcode select o_ctrl_unit <=

    s_RTYPE when "000000",            -- rtype the instruction
				      --immediates instructions
    "001111000100100"  when "001000", -- addi immediate

    "000000000000001"  when "010100", -- halt

    "001000000100100"  when "001001", -- addiu immediate
    "001001000100000"  when "001100", -- andi immediate
    "001010000100000"  when "001110", -- xori immediate
    "001001100100000"  when "001101", -- ori immediate
    "001011100100100"  when "001010", -- slti immediate
    "001011100100100"  when "001011", -- sltiu immediate
    "001011000100100"  when "001111", -- lui immediate

				      --branch, load, store, jump instructions
    "000101100001100"  when "000100", -- beq
    "000110000001100"  when "000101", -- bne
    "001000010100100"  when "100011", -- lw
    "001000001000100"  when "101011", -- sw
    "000000000000110"  when "000010", -- j
    "010000000100110"  when "000011", -- jal
    "000000000000000"  when others;

end dataflow;