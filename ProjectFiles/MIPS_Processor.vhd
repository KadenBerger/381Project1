-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;

entity MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

------------------------------------------------- Signals 

-- Inputs
signal i_immediateInput, i_PCInput : std_logic_vector(31 downto 0);

-- Component Outputs
signal s_ControlUnitOutput : std_logic_vector(14 downto 0);
signal regAOutput, regBOutput, aluSrcOutput, mem2RegOutput, adderOut, pcAdderOutput, signExtenderOutput : std_logic_vector(31 downto 0);
signal aluControlOutput : std_logic_vector(3 downto 0);
signal regDSTMuxOutput : std_logic_vector(4 downto 0);

-- General Signals
signal s_zeroFlag : std_logic;

component register_file is
	port(regfile_writeEnable: in std_logic;
	     regfile_CLK : in std_logic;
	     regfile_RST : in std_logic;
	     data_In: in std_logic_vector(31 downto 0);
	     srcA: in std_logic_vector(4 downto 0);
	     srcB: in std_logic_vector(4 downto 0);
	     dstReg : in std_logic_vector(4 downto 0);
	     readA: out std_logic_vector(31 downto 0);
	     readB: out std_logic_vector(31 downto 0));
end component;

component pc_fetch_logic is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_D          : in std_logic_vector(31 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(31 downto 0));   -- Data value output
end component;

component addersubtractor_N is
generic(N : integer := 32);
	port(A : in std_logic_vector(N-1 downto 0);
	     B : in std_logic_vector(N-1 downto 0);
	     nAdd_Sub : in std_logic;
             Sum : out std_logic_vector(N-1 downto 0);
	     Overflow : out std_logic;
	     Carryout : out std_logic);
end component;

component control_unit is
port(i_opcode : in std_logic_vector(5 downto 0);
     i_funct : in std_logic_vector(5 downto 0);
     o_ctrl_unit : out std_logic_vector(14 downto 0));
end component;

component ALU_Control is
    port(function_Code : in  std_logic_vector(5 downto 0); -- only use this if ALUOP is 10
	 ALUOP	       : in  std_logic_vector(3 downto 0); -- this should be (3 downto 0) of the opcode
	 ALUCONTROL    : out std_logic_vector(3 downto 0));
end component;

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

component sign_extender is
	port(extensionMode   : in std_logic;
	     i_Imm           : in std_logic_vector(15 downto 0);
             o_Extended      : out std_logic_vector(31 downto 0));
end component;

component mux2t1_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;

    IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2), -- memory address to read from
             data => iInstExt, -- input not sure what this does yet
             we   => iInstLd,  -- write enable
             q    => s_Inst);  -- outputted instruction (use this for control logic and register to read.


  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);


  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 

  pcandfetch : pc_fetch_logic
  port map(i_CLK        => iCLK,
           i_RST        => iRST,
           i_D          => pcAdderOutput,    -- FIX THIS LATER JUST TESTING
           o_Q          => s_NextInstAddr);  -- Next instruction, needed by instruction memory 

	pcadder : addersubtractor_N
	generic map(N => 32)
	port map(A 	  => s_NextInstAddr, -- previous pc instruction address
	         B        => X"00000004",	 -- add 4 for next instruction
	         nAdd_Sub => '0',
                 Sum      => pcAdderOutput);
	        -- Overflow => don't care about this
	        -- Carryout => don't care about this );

-- Guide for s_Inst bits
-- 31 downto 26 is the opcode  00000
-- 25 downto 21 is rs
-- 20 downto 16 is rt

-- FOR R-TYPE:
-- 15 downto 11 is rd
-- 10 downto 6 is shift amount
-- 5 downto 0 is function code

-- FOR I-TYPE:
-- 15 downto 0 is immediate

-- FOR J-TYPE:
-- 31 downto 26 is opcode
-- 25 downto 0 is the instruction address to jump to

 controlunit : control_unit
 port map(i_opcode   => s_Inst(31 downto 26), -- first 5 bits of instruciton for opcode
         i_funct     => s_Inst(5 downto 0),   -- last  bits of instruction for func code
         o_ctrl_unit  => s_ControlUnitOutput);

-- Control Unit Output Guide from drawing
-- 14 jr
-- 13 jal
-- 12 ALUSRC
-- 11 downto 8 CONTROL
-- 7 memtoreg
-- 6 dmemWE ?
-- 5 regWE
-- 4 reg_DST ?
-- 3 pcsrc 
-- 2 sign extension mode
-- 1 j
-- 0 halt

	regdstmux : mux2t1_N
	generic map(N => 5)
	port map(i_S  => s_ControlUnitOutput(4),
      		 i_D0 => s_Inst(20 downto 16),
      		 i_D1 => s_Inst(15 downto 11),
      		 o_O  => regDSTMuxOutput);

        registerfile : register_file
	port map(regfile_writeEnable => s_RegWr,
	     	 regfile_CLK  	     => iCLK,
	     	 regfile_RST 	     => iRST,
	     	 data_In	     => mem2RegOutput,-- this will be the output from mem2reg  TODO
	     	 srcA		     => s_Inst(25 downto 21), -- rs from instruciton
	     	 srcB		     => s_Inst(20 downto 16), -- rt from instruction
	     	 dstReg		     => regDSTMuxOutput,  -- implement the mux for this
	     	 readA		     => regAOutput,
	     	 readB		     => regBOutput);

	immediateExtender : sign_extender
	port map(extensionMode => s_ControlUnitOutput(2),			-- TODO
		 i_Imm 	       => s_Inst(15 downto 0),  -- imm part of instruction
		 o_Extended    => signExtenderOutput);
	
	immediateOrRegisterB : mux2t1_N  -- Selects if ALU Operand B is registerB or imm
	port map(i_S  => s_ControlUnitOutput(12),		--TODO
      		 i_D0 => regBOutput,
      		 i_D1 => signExtenderOutput,
      		 o_O  => aluSrcOutput); 

    ALUControl : ALU_Control
    port map(function_Code => s_Inst(5 downto 0),   -- function code from the end of the instruction
	     ALUOP	   => s_Inst(30 downto 27), -- first 4 bits of the op code
	     ALUCONTROL    => aluControlOutput);

	ALUunit : ALU
	port map(input_A 	    => regAOutput,
		 input_B 	    => aluSrcOutput,
		 shift_AmountOrByte => s_Inst(10 downto 6), -- shamt part of instruction
		 ALUCONTROL 	    => aluControlOutput,
		 zero_Flag	    => s_zeroFlag,		-- Make sure to use this for branch with and gate
		 overflow_Flag	    => s_Ovfl,
		-- carry_Out	    =>
		 result	     	    => adderOut);  -- check this
  

	adderOut <= OAluOut;		-- check this
	
	memtoregmux : mux2t1_N
	port map(i_S  => s_ControlUnitOutput(7),			-- TODO
      		 i_D0 => adderOut,
      		 i_D1 => s_DmemOUt,
      		 o_O  => mem2RegOutput);

--	jumpMux : mux2t1_N
--	port map(i_S  => s_ControlUnitOut(1),
 --     		 i_D0 => ,
 --     		 i_D1 => ,
 --     		 o_O  => );


end structure;

