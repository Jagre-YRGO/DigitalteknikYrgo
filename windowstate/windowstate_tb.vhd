-------------------------------------------------------------------------------
-- File        :  windowstate_tb.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-05-25
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  TB for Example based on 7.1
--                
-------------------------------------------------------------------------------

--library inclusion
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Entity
entity windowstate_tb is
end entity;

--Architecture
architecture rtl of windowstate_tb is

signal clk_s   : std_logic := '0';
signal rst_n_s : std_logic; --aktiv låg signal 
signal press_s : std_logic := '0';
signal cw_s    : std_logic;
signal ccw_s   : std_logic;

begin
   dut : entity work.windowstate
      port map(
         clk => clk_s,
         rst_n => rst_n_s,
         press => press_s,
         cw => cw_s,
         ccw => ccw_s
      );
      
   -------------------------------------------------------------------------------
   --clock generation process
   -------------------------------------------------------------------------------
   process
   begin
      --generate only a number of cykles so that simulatio stops
      for i in 0 to 200 loop
         clk_s <= not clk_s;
         wait for 10 ns;
      end loop;
      wait;
   end process;
   
   -------------------------------------------------------------------------------
   --input stimuli generation process
   -------------------------------------------------------------------------------
   process
   begin
      wait for 20 ns;
      rst_n_s <= '0';
      wait for 20 ns;
      rst_n_s <= '1';
      
      --vÃ¤nta några klockcykler
      wait for 59 ns;
      --tryck knapp i 30 ns, sedan släpp
      press_s <= '1';
      wait for 130 ns;
      press_s <= '0';
      --vÃ¤nta några klockcykler
      wait for 50 ns;

      --tryck knapp på nytt i 30 ns, sedan släpp
      --tryck knapp i 30 ns, sedan släpp
      press_s <= '1';
      wait for 30 ns;
      press_s <= '0';
      
      
      
      wait;
   end process;
end;
