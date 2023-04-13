-------------------------------------------------------------------------------
-- File        :  structural_tb.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-04-13
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Testbench for structural
--
-------------------------------------------------------------------------------

--lib inclusion
library IEEE;
use IEEE.std_logic_1164.all;

--entity declaration
entity structural_tb is
end entity;

--architecture
architecture tb of structural_tb is

signal i0_s, i1_s : std_logic_vector(3 downto 0) := "0000";
signal o0_s, o1_s : std_logic_vector(6 downto 0);

begin

   --Device under test instantiation
   dut : entity work.structural
   port map
   (
      i0 => i0_s,
      i1 => i1_s,
      o0 => o0_s,
      o1 => o1_s
   );
   
   --Test vectors
   i0_s <=  "0001" after 100 ps, 
            "0010" after 200 ps, 
            "0011" after 300 ps, 
            "1000" after 400 ps, 
            "1111" after 500 ps;
            
   i1_s <=  "0001" after 100 ps, 
            "0010" after 200 ps, 
            "0011" after 300 ps, 
            "1000" after 400 ps, 
            "1111" after 500 ps;
            
end architecture;