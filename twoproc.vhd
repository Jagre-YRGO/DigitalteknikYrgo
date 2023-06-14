-------------------------------------------------------------------------------
-- File        :  <filename>
-- Author      :  <your name>
-- Company     :  YRGO
-- Created     :  <date>
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  <A few words about this design>
--                
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

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

type reg_type is record
   button_n : std_logic;
   button   : std_logic;
   led      : std_logic;
end record;

signal r, ri : reg_type;

begin
   --combinatorial logic
   process(rst,button,led,r)
      variable v : reg_type;
   begin
      v := r;
      
      v.button := button;
      v.button_n := not(r.button);
      
      if r.button = '0' and r.button_n = '1' then
         v.led := not(r.led);
      end if;
      
      led <= r.led;
      
      ri := v;
   end process;

   --flip flops
   process(clk)
   begin
      if(rising_edge(clk)) then
         r <= ri;
      end if;
   end process;

 
end architecture;
