-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- multiplexer_32to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32 to 1 multiplexer using
-- a dataflow implementation
--
-- NOTES:
-- 9/24/24 by Kaden::Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


-- Entity
entity multiplexer_32to1 is
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
end multiplexer_32to1;

-- Architecture
architecture Dataflow of multiplexer_32to1 is
begin
    -- Implementing the multiplexer behavior using a select statement
    with sel select
        output <= input0 when "00000", -- Select input0
                  input1 when "00001", -- Select input1
                  input2 when "00010", -- Select input2
                  input3 when "00011", -- Select input3
                  input4 when "00100", -- Select input4
                  input5 when "00101", -- Select input5
                  input6 when "00110", -- Select input6
                  input7 when "00111", -- Select input7
                  input8 when "01000", -- Select input8
                  input9 when "01001", -- Select input9
                  input10 when "01010", -- Select input10
                  input11 when "01011", -- Select input11
                  input12 when "01100", -- Select input12
                  input13 when "01101", -- Select input13
                  input14 when "01110", -- Select input14
                  input15 when "01111", -- Select input15
                  input16 when "10000", -- Select input16
                  input17 when "10001", -- Select input17
                  input18 when "10010", -- Select input18
                  input19 when "10011", -- Select input19
                  input20 when "10100", -- Select input20
                  input21 when "10101", -- Select input21
                  input22 when "10110", -- Select input22
                  input23 when "10111", -- Select input23
                  input24 when "11000", -- Select input24
                  input25 when "11001", -- Select input25
                  input26 when "11010", -- Select input26
                  input27 when "11011", -- Select input27
                  input28 when "11100", -- Select input28
                  input29 when "11101", -- Select input29
                  input30 when "11110", -- Select input30
                  input31 when "11111", -- Select input31
                  X"00000000" when others; -- Default case (optional)
end Dataflow;



