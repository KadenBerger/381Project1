-------------------------------------------------------------------------
-- Kaden Berger
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- ALU_Control.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the ALU implementation
-- NOTES:
-- 10/17/24 by KAB:Design Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


-- Entity
entity ALU_Control is
    port(function_Code : in  std_logic_vector(5 downto 0); -- only use this if ALUOP is 10
	 ALUOP	       : in  std_logic_vector(3 downto 0); -- this should be (3 downto 0) of the opcode
	 ALUCONTROL    : out std_logic_vector(3 downto 0));
end ALU_Control;

-- Architecture
architecture behavior of ALU_Control is

--Components


--Signal Declarations

begin

	process(function_Code, ALUOP, ALUCONTROL)
	begin
		if(ALUOP = "0000") then --R format instruction, use the function code to determine which output
			if(function_Code = "100000") then 
				ALUCONTROL <= "0000"; 		-- add
			elsif(function_Code = "100010") then 
				ALUCONTROL <= "0001"; 		-- sub
			elsif(function_Code = "100001") then
				ALUCONTROL <= "1100";		-- addu
			elsif(function_Code = "100011") then
				ALUCONTROL <= "1101";		-- subu
			elsif(function_Code = "000000") then
				ALUCONTROL <= "0100";		-- srl
			elsif(function_Code = "000010") then
				ALUCONTROL <= "0101";		-- sll
			elsif(function_Code = "000011") then
				ALUCONTROL <= "0110";		-- sra			
			elsif(function_Code = "100100") then
				ALUCONTROL <= "0111";		-- AND
			elsif(function_Code = "100101") then
				ALUCONTROL <= "1000";		-- OR
			elsif(function_Code = "100110") then
				ALUCONTROL <= "1001";		-- XOR
			elsif(function_Code = "100111") then
				ALUCONTROL <= "1010";		-- NOR
			elsif(function_Code = "101010") then
				ALUCONTROL <= "1011";		-- SLT 
			else ALUCONTROL <= "0011";		--IF function code is unknown or wrong ALUCONTROL is 0011(unused) 
			end if;			-- Don't implement repl.qb yet i guess (i don't know where it goes)
		elsif(ALUOP = "0011" or ALUOP = "1011") then -- lw or sw
			ALUCONTROL <= "0000"; -- use add (need to add offset so use add)
		elsif(ALUOP = "0100" or ALUOP = "0101") then	-- beq or bne
			ALUCONTROL <= "0001"; -- use sub (if zeroflag = 1 then you know they are equal, if 0 they are not equal)
		elsif(ALUOP = "1000") then 		-- addi
			ALUCONTROL <= "0000"; -- use add
		elsif(ALUOP = "1001") then 		-- addiu
			ALUCONTROL <= "1100"; -- use addu
		elsif(ALUOP = "1100") then 		-- andi
			ALUCONTROL <= "0111"; -- use AND
		elsif(ALUOP = "1110") then 		-- xori
			ALUCONTROL <= "1001"; -- use XOR
		elsif(ALUOP = "1101") then		-- ori
			ALUCONTROL <= "1000"; -- use OR
		elsif(ALUOP = "1010") then		-- slti
			ALUCONTROL <= "1011"; -- use slt
		elsif(ALUOP = "1111") then 		-- lui
			ALUCONTROL <= "0101"; -- use sll
		else ALUCONTROL <= "0000";
		end if;

--result <= adder_Output   when "1100", -- add
--	  adder_Output   when "1101", -- sub
--	  adder_Output   when "0010", -- addu
--	  adder_Output   when "0011", -- subu
--	  shifter_Output when "0100", -- srl
--	  shifter_Output when "0101", -- sll
--	  shifter_Output when "0110", -- sra
--	  and_Output	 when "0111", -- AND
--	  or_Output	 when "1000", -- OR
--	  xor_Output	 when "1001", -- XOR
--	  nor_Output	 when "1010", -- NOR
--	  slt_Output	 when "1011", -- SLT
--	  replqb_Output  when "1111", -- repl.qb 
--	  X"00000000" when others;

end process;
end behavior;
