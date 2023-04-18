-------------------------------------------------------------------------------
-- File        :  sevenseg_pkg.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-04-15
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Package file for 7-segment decoder
-------------------------------------------------------------------------------

--lib inclusion
library IEEE;
use IEEE.std_logic_1164.all;

package sevenseg_pkg is

   type sevenseg_bitorder is  (msb_as_segment_A, lsb_as_segment_A);
   type sevenseg_polarity is  (common_cathode, common_anode);
   
   constant SEGMENTS_0  : std_logic_vector(6 downto 0) := "1111110";
   constant SEGMENTS_1  : std_logic_vector(6 downto 0) := "0110000";
   constant SEGMENTS_2  : std_logic_vector(6 downto 0) := "1101101";
   constant SEGMENTS_3  : std_logic_vector(6 downto 0) := "1111001";
   constant SEGMENTS_4  : std_logic_vector(6 downto 0) := "0110011";
   constant SEGMENTS_5  : std_logic_vector(6 downto 0) := "1011011";
   constant SEGMENTS_6  : std_logic_vector(6 downto 0) := "1011111";
   constant SEGMENTS_7  : std_logic_vector(6 downto 0) := "1110000";
   constant SEGMENTS_8  : std_logic_vector(6 downto 0) := "1111111";
   constant SEGMENTS_9  : std_logic_vector(6 downto 0) := "1110011";
   constant SEGMENTS_A  : std_logic_vector(6 downto 0) := "1110111";
   constant SEGMENTS_B  : std_logic_vector(6 downto 0) := "0011111";
   constant SEGMENTS_C  : std_logic_vector(6 downto 0) := "0001101";
   constant SEGMENTS_D  : std_logic_vector(6 downto 0) := "0111101";
   constant SEGMENTS_E  : std_logic_vector(6 downto 0) := "1001111";
   constant SEGMENTS_F  : std_logic_vector(6 downto 0) := "1000111";
   constant SEGMENTS_OFF: std_logic_vector(6 downto 0) := "0000000";
   
end;