-------------------------------------------------------------------------------
-- File        :  L15-RAM_tb.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-05.17
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Basic testbench for RAM
--                
-------------------------------------------------------------------------------

--lib inclusion
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


--Entity
entity L15_RAM_tb is
end entity;

architecture my_tb of L15_RAM_tb is

signal clk_s   : std_logic := '0';
signal we_s    : std_logic;
signal adr_s   : integer range 0 to 15;
signal dtai_s  : std_logic_vector(7 downto 0);
signal dtao_s  : std_logic_vector(7 downto 0);


begin
   ----------------------------------------------------------------------------
   -- Instantiate the DUT
   ----------------------------------------------------------------------------
   dut:entity work.L15_RAM
      port map (
         clk => clk_s,
         we  => we_s,
         adr => adr_s,
         dtai=> dtai_s,
         dtao=> dtao_s
      );
      
      
   -------------------------------------------------------------------------------
   --clock generation process
   -------------------------------------------------------------------------------
   process
   begin
      clk_s <= not clk_s;
      wait for 10 ns;
   end process;
   
   -------------------------------------------------------------------------------
   --data write/read process
   -------------------------------------------------------------------------------
   process
   begin
      --write some data
      for i in 0 to 15 loop
         dtai_s <= std_logic_vector(to_unsigned(i,8));
         adr_s <= i;
         we_s <= '1';
         wait until rising_edge(clk_s);
      end loop;

      we_s <= '0';
      wait until rising_edge(clk_s);
   
      --read back data
      for i in 0 to 15 loop
         adr_s <= i;
         wait until rising_edge(clk_s);
      end loop;

   end process;
     
end;

