-------------------------------------------------------------------------------
-- File        :  flankdetect.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-04-27
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Lit LED on button press, turn off on second press
--                
-------------------------------------------------------------------------------

--lib inclusion
library IEEE;
use IEEE.std_logic_1164.all;

--entity declaration
entity flankdetect is
   port
   (
      clk   : in  std_logic;
      rst   : in  std_logic;
      button: in  std_logic;
      led   : out std_logic
   );
end entity;

--architecture
architecture rtl of flankdetect is

signal button_S, led_s, button_n : std_logic;

begin

   button_n <= not(button);

   process(clk,rst)
   begin
      if rst = '0' then
         button_S <= '0';
         led_s    <= '0';
      elsif(rising_edge(clk)) then
         button_s <= button_n;
         
         if button_s = '0' and button_n = '1' then
            led_s <= not(led_s);
         end if;
      end if;
   end process;

   led <= led_s;
   
end architecture;