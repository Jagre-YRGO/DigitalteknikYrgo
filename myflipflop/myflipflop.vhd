-------------------------------------------------------------------------------
-- File        :  myflipflop.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-04-25
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  My first sequential VHDL for a 3 bit shiftregister
-------------------------------------------------------------------------------

--lib inclusion
library IEEE;
use IEEE.std_logic_1164.all;

--entity declaration
entity myflipflop is
   port
   (
      clk   : in std_logic;   --klock ingång
      d     : in std_logic;   --data ingång
      q     : out  std_logic    --data (q) utgång
   );
end entity;

--architecture
architecture rtl of myflipflop is

--signaler för att ansluta vipporna till varandra
signal q1 : std_logic;
signal apan : std_logic;

begin
	process(clk) is --sensivity list "start-skott" för processen
	begin 
		if(rising_edge(clk)) then
         --var tilldelning i den "klockade" processen resulterar i en vippa
         --tilldelning av första vippan
         q1 <= d;

         --tilldelning av mellan vippan
         apan <= q1;

         --tilldelning av sista vippan
			q <= apan;
		end if;
	end process; 
end architecture;