-------------------------------------------------------------------------------
-- File        :  countbits.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-18
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description : Solution for assignment "Räkna bitar" (count bits)
-------------------------------------------------------------------------------

--lib inclusion
library IEEE;
use IEEE.std_logic_1164.all;

--entity declaration
entity countbits is
   port
   (
      i : in  std_logic_vector(2 downto 0);
      o : out std_logic_vector(1 downto 0)
   );
end entity;

--architecture
architecture gate of countbits is

begin
   o(0) <= (i(2) xor i(1)) xor i(0);
   o(1) <= (i(1) and i(0)) or (i(0) and i(2)) or (i(2) and i(1));
            
end architecture;