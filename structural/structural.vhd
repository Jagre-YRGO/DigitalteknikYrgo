-------------------------------------------------------------------------------
-- File        :  structural.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-04-12
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  2 7-segmentdecoders that take input from sliding switches
--
-------------------------------------------------------------------------------

--lib inclusion
library IEEE;
use IEEE.std_logic_1164.all;

--entity declaration
entity structural is
   port
   (
      i0 : in  std_logic_vector(3 downto 0); --binary value that should be lit on disp 0
      i1 : in  std_logic_vector(3 downto 0); --binary value that should be lit on disp 1
      o0 : out std_logic_vector(6 downto 0); --segments to display 0
      o1 : out std_logic_vector(6 downto 0)  --segments to display 1
   );
end entity;

--architecture
architecture rtl of structural is

signal i0_s, i1_s : std_logic_vector(3 downto 0);
signal o0_s, o1_s : std_logic_vector(6 downto 0);

begin

   --First 7-segement display module
   disp0 : entity work.sevenseg
      port map(
         i => i0_s,
         o => o0_s
      );
               
   --Second 7-segement display module
   disp1 : entity work.sevenseg
      port map(
         i => i1_s,
         o => o1_s
      );

   --assign outputs
   i0_s  <= i0;
   i1_s  <= i1;
   o0    <= o0_s;
   o1    <= o1_s;

      
end architecture;