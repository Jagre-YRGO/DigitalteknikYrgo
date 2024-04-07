-------------------------------------------------------------------------------
-- File        :  CarBreak.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-04-11
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Basic example of a carbreak descission unit
--                
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity CarBreak is
	port
	(
		pedal, camera, radar	: in std_logic;
		break    				: out std_logic
	);
end entity;

architecture Behaviour of CarBreak is

begin
	break <= pedal or (camera and radar);
end architecture;