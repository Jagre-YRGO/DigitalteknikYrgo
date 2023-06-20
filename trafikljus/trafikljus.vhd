-------------------------------------------------------------------------------
-- File        :  trafikljus.vhd
-- Author      :  Erik Jagre
-- Company     :  YRGO
-- Created     :  2023-06-15
-- Platform    :  Quartus/Modlesim/Windows
-- Standard    :  VHDL 93
-------------------------------------------------------------------------------
-- Description :  Solution to trafikljuset assignment using
--                Jira Gailser 2-process coding
--                
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity declaration
entity trafikljus is
   port
   (
      clk         : in  std_logic;
      rst         : in  std_logic;
      traffic_ns  : in  std_logic;
      traffic_we  : in  std_logic;
      green_ns    : out std_logic;
      yellow_ns   : out std_logic;
      red_ns      : out std_logic;
      green_we    : out std_logic;
      yellow_we   : out std_logic;
      red_we      : out std_logic
   );
end entity;

--architecture
architecture rtl of trafikljus is

constant S1CYCLES : integer := 50;

type fsm_type is (all_red, we_yellow, ns_yellow, we_green, ns_green, we_redyellow, ns_redyellow);

type reg_type is record
   traffic_ns : std_logic;
   traffic_we : std_logic;
   tmr        : unsigned(26 downto 0);
   state      : fsm_type;
end record;

signal r, ri : reg_type := ('0','0',(others => '0'), all_red);

begin
   --combinatorial logic
   process(rst,r,traffic_ns,traffic_we)
      variable v : reg_type;
   begin
      v := r;
      
      v.traffic_ns := traffic_ns;
      v.traffic_we := traffic_we;
      
      v.tmr := r.tmr + 1;
      
      green_ns    <= '0';
      yellow_ns   <= '0';
      red_ns      <= '0';
      green_we    <= '0';
      yellow_we   <= '0';
      red_we      <= '0';

      case r.state is
         when all_red =>
            if traffic_ns = '1' and r.traffic_ns = '0' then
               v.state := ns_redyellow;
               v.tmr := (others => '0');
            elsif traffic_we = '1' and r.traffic_we = '0' then
               v.state := we_redyellow;
               v.tmr := (others => '0');
            end if;
            red_ns      <= '1';
            red_we      <= '1';
            
         when ns_redyellow =>
            if r.tmr = 1*S1CYCLES then
               v.state := ns_green;
               v.tmr := (others => '0');
            end if;
            red_we      <= '1';
            yellow_ns   <= '1';
            red_ns      <= '1';
            
         when ns_green =>
            if r.tmr = 1*S1CYCLES then
               v.state := ns_yellow;
               v.tmr := (others => '0');
            end if;
            red_we      <= '1';
            green_ns    <= '1';
            
         when ns_yellow =>
            if r.tmr = 1*S1CYCLES then
               v.state := all_red;
            end if;
            red_we      <= '1';
            yellow_ns    <= '1';
         
         when we_redyellow =>
            if r.tmr = 1*S1CYCLES then
               v.state := we_green;
               v.tmr := (others => '0');
            end if;
            red_we      <= '1';
            yellow_we   <= '1';
            red_ns      <= '1';
            
         when we_green =>
            if r.tmr = 1*S1CYCLES then
               v.state := we_yellow;
               v.tmr := (others => '0');
            end if;
            red_ns      <= '1';
            green_we    <= '1';
            
         when we_yellow =>
            if r.tmr = 1*S1CYCLES then
               v.state := all_red;
            end if;
            red_ns      <= '1';
            yellow_we    <= '1';

         when others =>
            v.state := all_red;
      end case;
      
      ri <= v;
   end process;

   --flip flops
   process(clk)
   begin
      if(rising_edge(clk)) then
         r <= ri;
      end if;
   end process;

 
end architecture;