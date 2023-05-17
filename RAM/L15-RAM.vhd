-------------------------------------------------------------------------------
-- File        :  L15-RAM.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-05.17
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Basic RAM
--                
-------------------------------------------------------------------------------

--lib inclusion
library IEEE;
use IEEE.std_logic_1164.all;


--Entity
entity L15_RAM is
   port(
      clk   : in  std_logic;
      we    : in  std_logic;
      adr   : in  integer range 0 to 15;
      dtai  : in  std_logic_vector(7 downto 0);
      dtao  : out std_logic_vector(7 downto 0)
   );
end entity;

--Architecture
architecture rtl of L15_RAM is

type ram16x8 is array (0 to 15) of std_logic_vector(7 downto 0);
signal my_ram : ram16x8;

begin
   process(clk) is
   begin
      if (rising_edge(clk)) then
         if (we = '1') then
            my_ram(adr) <= dtai;
         end if;
      end if;
   end process;
   dtao <= my_ram(adr);

end architecture;


