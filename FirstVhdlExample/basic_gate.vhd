-------------------------------------------------------------------------------
-- File        :  basic_gate.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-03-23
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  A very basic design for beginners
--                
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity basic_gate is
   port
   (
      in_a  : in std_logic;
      in_B  : in std_logic;
      out_0 : out std_logic
   );
end entity;

architecture rtl of basic_gate is
begin
   out_0 <= in_a and in_b;
end architecture;



