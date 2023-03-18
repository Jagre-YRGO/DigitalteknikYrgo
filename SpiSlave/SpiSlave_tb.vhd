library ieee;
use ieee.std_logic_1164.all;

--*ENTITY*
entity spi_slave_tb is
	port(ok : out std_logic := '1');
end;


architecture tb of spi_slave_tb is

signal spi_clk, spi_mosi : std_logic := '0';
signal dta : std_logic_vector(7 downto 0) := X"81";

begin
  --*COMBINATORIAL LGOIC*
   process
   begin
      wait for 10 us;
   
      for i in 0 to 7 loop
         spi_mosi <= dta(7);
         dta <= dta(6 downto 0) & '0';
         wait for 1 us;
         spi_clk <= '1';
         wait for 1 us;
         spi_clk <= '0';
      end loop;

      report "end of simulation";
      
      wait;
      
   end process;
   
end;

