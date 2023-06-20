-------------------------------------------------------------------------------
-- File        :  trafikljus_tb.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-06-15
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Testbench for Solution to trafikljuset assignment using
--                Jira Gailser 2-process coding
--                
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--entity declaration
entity trafikljus_tb is
end entity;

--architecture
architecture tb of trafikljus_tb is

signal clk_s         : std_logic := '0';
signal rst_s         : std_logic;
signal traffic_ns_s  : std_logic := '0';
signal traffic_we_s  : std_logic := '0';
signal green_ns_s    : std_logic;
signal yellow_ns_s   : std_logic;
signal red_ns_s      : std_logic;
signal green_we_s    : std_logic;
signal yellow_we_s   : std_logic;
signal red_we_s      : std_logic;


begin
   dut : entity work.trafikljus
      port map(
         clk => clk_s,
         rst => rst_s,
         traffic_ns => traffic_ns_s,
         traffic_we => traffic_we_s,
         green_ns => green_ns_s,
         yellow_ns => yellow_ns_s,
         red_ns => red_ns_s,
         green_we => green_we_s,
         yellow_we => yellow_we_s,
         red_we => red_we_s
      );
      
   process
   begin
      clk_S <= not clk_s;
      wait for 10 ns;
   end process;

   process
   begin
      wait for 100 ns;
      traffic_ns_s <= '1';
      wait for 100 ns;
      traffic_ns_s <= '0';

      wait until red_ns_s = '1';
      
      wait for 100 ns;
      traffic_we_s <= '1';
      wait for 100 ns;
      traffic_we_s <= '0';
      
      wait until red_we_s = '1';
      
      wait for 100 ns;
      assert false
      report "End of simulation"
      severity failure;
      
      wait;
   end process;
   
end architecture;