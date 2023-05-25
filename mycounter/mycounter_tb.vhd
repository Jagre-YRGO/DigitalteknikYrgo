-------------------------------------------------------------------------------
-- File        :  mycounter_tb.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-05-24
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Testbench for a 4 bit counter with wrap around
--                
-------------------------------------------------------------------------------

--library inclusion
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Entity
entity mycounter_tb is
end entity;

--Architecture
architecture rtl of mycounter_tb is

signal led_s   : std_logic := '0';
signal clk_s   : std_logic := '0';
signal rst_n_s : std_logic := '0';

begin
   dut : entity work.mycounter
      port map(clk_s, rst_n_s, led_s);

   process is
   begin
      for i in 0 to 200 loop
         clk_s <= not clk_s;
         wait for 10 ns;
      end loop;
      wait;
   end process;
   
   process is
   begin
      wait for 100 ns;
      rst_n_s <= '1';
      wait for 1005 ns;
      rst_n_s <= '0';
      wait;
   end process;
   
   
end;