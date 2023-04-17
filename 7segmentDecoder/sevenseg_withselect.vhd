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

library work;
use work.sevenseg_pkg.all;

--entity declaration
entity sevenseg is
   generic
   (
      output_swap    : sevenseg_bitorder := msb_as_segment_A;
      output_invert  : sevenseg_polarity := common_anode
   );
   port
   (
      i : in  std_logic_vector(3 downto 0); --binary value that should be lit on disp
      o : out std_logic_vector(6 downto 0)  --segments to display
   );
end entity;

--architecture
architecture struct of sevenseg is

signal o_inv : std_logic_vector(6 downto 0);

begin
   --truth table for segments based on input
   --Assuming that lit segment is logic high '1'
   with i select
      o_inv <= SEGMENTS_0 when "0000", --0
               SEGMENTS_1 when "0001", --1
               SEGMENTS_2 when "0010", --2
               SEGMENTS_3 when "0011", --3
               SEGMENTS_4 when "0100", --4
               SEGMENTS_5 when "0101", --5
               SEGMENTS_6 when "0110", --6
               SEGMENTS_7 when "0111", --7
               SEGMENTS_8 when "1000", --8
               SEGMENTS_9 when "1001", --9
               SEGMENTS_A when "1010", --A
               SEGMENTS_B when "1011", --b
               SEGMENTS_C when "1100", --c
               SEGMENTS_D when "1101", --d
               SEGMENTS_E when "1110", --E
               SEGMENTS_F when "1111", --F
               SEGMENTS_OFF when others;
               
   --7-segment displays on FPGA developmentboards are 
   --common anode -> logic low '0' lits segment
   --hence all bits needs to be inverted
	process(o_inv) is
	begin
      if output_invert = common_anode then
         if (output_swap = msb_as_segment_A) then
            o(0) <= not(o_inv(6));
            o(1) <= not(o_inv(5));
            o(2) <= not(o_inv(4));
            o(3) <= not(o_inv(3));
            o(4) <= not(o_inv(2));
            o(5) <= not(o_inv(1));
            o(6) <= not(o_inv(0));
         else
            o <= not(o_inv);
         end if;
      else
         if (output_swap = msb_as_segment_A) then
            o(0) <= o_inv(6);
            o(1) <= o_inv(5);
            o(2) <= o_inv(4);
            o(3) <= o_inv(3);
            o(4) <= o_inv(2);
            o(5) <= o_inv(1);
            o(6) <= o_inv(0);
         else
            o <= o_inv;
         end if;
      end if;
	end process;
   
end architecture;