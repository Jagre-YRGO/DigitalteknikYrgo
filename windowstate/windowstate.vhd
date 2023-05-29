-------------------------------------------------------------------------------
-- File        :  windowstate.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-05-25
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Example based on 7.1 in Introduction to logic circuits &
--                logic design in VHDL
--                
-------------------------------------------------------------------------------

--library inclusion
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Entity
entity windowstate is
   port(
      clk   : in std_logic;
      rst_n : in std_logic; --aktiv låg
      press : in std_logic;
      cw    : out std_logic;
      ccw   : out std_logic
   );
end entity;

--Architecture
architecture rtl of windowstate is

-- Build an enumerated type for the state machine
type state_type is (w_closed, w_open, w_closing, w_opening);

-- Register to hold the current state
signal window_state : state_type;


begin
   process(clk,rst_n) is
   begin
      if rst_n = '0' then
         window_state <= w_closed;
      elsif rising_edge(clk) then
			-- Determine the next state synchronously, based on
			-- the current state and the input
			case window_state is
				when w_closed=>
					if press = '1' then
						window_state <= w_opening;
					else
						window_state <= w_closed;
					end if;
               
				when w_open=>
					if press = '1' then
						window_state <= w_closing;
					else
						window_state <= w_open;
					end if;
               
            when w_opening=>
               if press = '1' then
                  window_state <= w_opening;
               else
                  window_state <= w_open;
               end if;
               
            when w_closing=>
               if press = '1' then
                  window_state <= w_closing;
               else
                  window_state <= w_closed;
               end if;
               
               
			end case;
      end if;
   end process;
   
	-- Determine the output based only on the current state
	-- not the input! (this is a More machine).
	process (window_state, press)
	begin
			case window_state is
				when w_closed=>
               cw <= '0';
               ccw <= '0';

            when w_open=>
               cw <= '0';
               ccw <= '0';

            when w_opening=>
               cw <= '1';
               ccw <= '0';

            when w_closing=>
               cw <= '0';
               ccw <= '1';
            
			end case;
	end process;
   
end;
