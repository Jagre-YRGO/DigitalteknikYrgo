-------------------------------------------------------------------------------
-- File        :  SpiSlave_tb.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-03-18
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Testbench for SPI slave-interface.
--                Emulates a SPI master.  
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- entity just keeping one dummy-output
entity spi_slave_tb is
	port(ok : out std_logic := '1');
end;


architecture tb of spi_slave_tb is

--signals for testobject interconnect
signal spi_clk    : std_logic := '0';
signal spi_mosi   : std_logic := '0';
signal dta        : std_logic_vector(7 downto 0) := X"81";

-------------------------------------------------------------------------------
--procedure for shifting out data on SPI bus
-------------------------------------------------------------------------------
procedure bus_write(
   data : in  std_logic_vector(7 downto 0);
   signal sclk : out std_logic;
   signal mosi : out std_logic)
is
   variable dta_v : std_logic_vector(7 downto 0);
begin
   dta_v := data;                         -- store data locally
   for i in 0 to 7 loop
      mosi <= dta_v(7);
      dta_v := dta_V(6 downto 0) & '0';   -- shift
      wait for 1 us;
      sclk <= '1';                        -- toggle serial clock
      wait for 1 us;
      sclk <= '0';
   end loop;
end;
-------------------------------------------------------------------------------


begin
  -- stimuli section
   process
   begin
      -- wait a little for better visibility in wave window
      wait for 10 us;
   
      -- write som random data from master to slave
      bus_write(X"81",spi_clk, spi_mosi); wait for 2 us;
      bus_write(X"11",spi_clk, spi_mosi); wait for 2 us;
      bus_write(X"AB",spi_clk, spi_mosi); wait for 2 us;
      bus_write(X"00",spi_clk, spi_mosi); wait for 2 us;
      
      -- notify user user that simulation has reached the end
      report "end of simulation";
      
      -- wait forever (stop simulator from running besarc)
      wait;
      
   end process;
   
end;

