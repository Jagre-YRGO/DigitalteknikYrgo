-------------------------------------------------------------------------------
-- File        :  sevenseg.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-04-11
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  7-segmentdecoder with/select 
--                output MSB = segment A
--                output LSB = segment G
--                
-------------------------------------------------------------------------------

--lib inclusion
library IEEE;
use IEEE.std_logic_1164.all;

--entity declaration
entity sevenseg is
   port
   (
      i : in  std_logic_vector(3 downto 0); --binary value that should be lit on disp
      o : out std_logic_vector(6 downto 0)  --segments to display
   );
end entity;

--architecture
architecture rtl of sevenseg is

signal o_inv : std_logic_vector(6 downto 0);

begin
   --truth table for segments based on input
   --Assuming that lit segment is logic high '1'
   with i select
      o_inv <= "1111110" when "0000", --0
               "0110000" when "0001", --1
               "1101101" when "0010", --2
               "1111001" when "0011", --3
               "0110011" when "0100", --4
               "1011011" when "0101", --5
               "1011111" when "0110", --6
               "1110000" when "0111", --7
               "1111111" when "1000", --8
               "1110011" when "1001", --9
               "1110111" when "1010", --A
               "0011111" when "1011", --b
               "0001101" when "1100", --c
               "0111101" when "1101", --d
               "1001111" when "1110", --E
               "1000111" when "1111", --F
               "0000000" when others;
               
   --7-segment displays on FPGA developmentboards are 
   --common anode -> logic low '0' lits segment
   --hence all bits needs to be inverted
   o <= not(o_inv);
               
end architecture;