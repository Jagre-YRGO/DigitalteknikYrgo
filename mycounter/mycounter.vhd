-------------------------------------------------------------------------------
-- File        :  mycounter.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-05-24
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  a 4 bit counter with wrap around
--                
-------------------------------------------------------------------------------

--library inclusion
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Entity
entity mycounter is
   port(
      clk   : in std_logic;
      rst_n : in std_logic; --aktiv låg
      led   : out std_logic
   );
end entity;

--Architecture
architecture rtl of mycounter is

signal cnt_s : unsigned(25 downto 0);
signal led_s : std_logic;

begin
   process(clk,rst_n) is
   begin
      if rst_n = '0' then
         cnt_s <= (others => '0');
         led_s <= '0';
      elsif rising_edge(clk) then
         cnt_s <= cnt_s + 1;
         
         --om cnt_s är (50e6)-1, växla värde på led utgång
         --och nollställ räknaren
         if cnt_s = 49999999 then
--         if cnt_s = 49 then
            led_s <= not led_s;
            cnt_s <= to_unsigned(0,26);
         end if;
         
      end if;
   end process;
   
   led <= led_s;
end;