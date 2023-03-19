library IEEE;
use IEEE.std_logic_1164.all;

entity spi_slave is
   port
   (
      clk      : in std_logic;
      sclk     : in std_logic;
      mosi     : in std_logic;
      dtareg   : out std_logic_vector(7 downto 0)
   );
end entity;

architecture rtl of spi_slave is

signal old_sclk   : std_logic;
signal shiftreg   : std_logic_vector(7 downto 0);

begin
	process(clk) is 
	begin 
		if(rising_edge(clk)) then
         old_sclk <= sclk;
         if old_sclk = '0' and sclk ='1' then
            shiftreg <= shiftreg(6 downto 0) & mosi;
         end if;
			
		end if;
	end process; 
   
   dtareg <= shiftreg;
end architecture;



