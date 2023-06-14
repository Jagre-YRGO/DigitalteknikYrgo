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
--                Demands a text-file named 'numbers.txt' with test values in
--                DigitalteknikYrgo\SpiSlave\simulation\modelsim\
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

-- entity just keeping one dummy-output
entity spi_slave_tb is
	port(ok : out std_logic := '1');
end;


architecture tb of spi_slave_tb is

--signals for testobject interconnect
signal clk_s      : std_logic := '0';
signal spi_mosi_s : std_logic := '0';
signal spi_clk_s  : std_logic := '0';
signal dta_s      : std_logic_vector(7 downto 0) := X"81";

-------------------------------------------------------------------------------
--procedure for shifting out data on SPI bus
-------------------------------------------------------------------------------
procedure bus_write(
   data : in  integer;
   signal sclk : out std_logic;
   signal mosi : out std_logic)
is
   variable dta_v : std_logic_vector(7 downto 0);
begin
   dta_v := std_logic_vector(to_unsigned(data,8));                         -- store data locally

   assert dta_v(7 downto 4) < X"A"
   report "Data exceeded 9!"
   severity warning; 

   for i in 0 to 7 loop
      mosi <= dta_v(7);
      dta_v := dta_V(6 downto 0) & '0';   -- shift
      wait for 1 us;
      sclk <= '1';                        -- toggle serial clock
      wait for 1 us;
      sclk <= '0';
   end loop;
end;



begin
   -------------------------------------------------------------------------------
   --clock generation process
   -------------------------------------------------------------------------------
   process
   begin
      clk_s <= not clk_s;
      wait for 10 ns;
   end process;


   ----------------------------------------------------------------------------
   -- Instantiate the DUT
   ----------------------------------------------------------------------------
   dut:entity work.spi_slave
      port map (
         clk   => clk_s,
         sclk  => spi_clk_s,
         mosi  => spi_mosi_s,
         dtareg=> dta_s
      );

   -- stimuli section
   process
      -- open file with values to transmit over SPI
      file input_file : text open read_mode is "numbers.txt";
      variable line_buf : line;
      variable my_integer : integer;
   begin
      -- wait a little for better visibility in wave window
      wait for 10 us;
   
      -- write som random data from master to slave
      while not endfile(input_file) loop
         readline(input_file, line_buf);
         read(line_buf, my_integer);
         bus_write(my_integer, spi_clk_s, spi_mosi_s); wait for 2 us;
      end loop;
      
      file_close(input_file);
      
      -- notify user user that simulation has reached the end
      while true loop
         assert now < 100 us
         report "end of simulation"
         severity failure;
         wait for 1 us;
      end loop;

      
      -- wait forever (stop simulator from running besarc)
      wait;
      
   end process;
   
end;

