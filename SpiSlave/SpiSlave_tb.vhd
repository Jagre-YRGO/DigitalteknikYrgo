library ieee;
use ieee.std_logic_1164.all;

--*ENTITY*
entity spi_slave_tb is
	port(ok : out std_logic := '1');
end;


architecture tb of spi_slave_tb is

signal spi_clk, spi_mosi : std_logic := '0';
signal dta : std_logic_vector(7 downto 0) := X"81";


procedure bus_write(
   data : in  std_logic_vector(7 downto 0);
   signal sclk : out std_logic;
   signal mosi : out std_logic)
is
   variable dta_v : std_logic_vector(7 downto 0);
begin
   dta_v := data;
   for i in 0 to 7 loop
      mosi <= dta_v(7);
      dta_v := dta_V(6 downto 0) & '0';
      wait for 1 us;
      sclk <= '1';
      wait for 1 us;
      sclk <= '0';
   end loop;
end;

begin
  --*COMBINATORIAL LGOIC*
   process
   begin
      wait for 10 us;
   
      bus_write(X"81",spi_clk, spi_mosi); wait for 2 us;
      bus_write(X"11",spi_clk, spi_mosi); wait for 2 us;
      bus_write(X"AB",spi_clk, spi_mosi); wait for 2 us;
      bus_write(X"00",spi_clk, spi_mosi); wait for 2 us;
      report "end of simulation";
      
      wait;
      
   end process;
   
end;

