--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:25:07 04/02/2015
-- Design Name:   
-- Module Name:   C:/Users/manuel/Documents/ISE/display_7seg_modify/manual_tb.vhd
-- Project Name:  display_7seg_modify
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: manual
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY manual_tb IS
END manual_tb;
 
ARCHITECTURE behavior OF manual_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT manual
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         SW0 : IN  std_logic;
         SW1 : IN  std_logic;
         SW2 : IN  std_logic;
         SW3 : IN  std_logic;
         SW4 : IN  std_logic;
         SW5 : IN  std_logic;
         SW6 : IN  std_logic;
         SW7 : IN  std_logic;
         flag1 : OUT  std_logic;
         flag2 : OUT  std_logic;
         bits : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal SW0 : std_logic := '0';
   signal SW1 : std_logic := '0';
   signal SW2 : std_logic := '0';
   signal SW3 : std_logic := '0';
   signal SW4 : std_logic := '0';
   signal SW5 : std_logic := '0';
   signal SW6 : std_logic := '0';
   signal SW7 : std_logic := '0';

 	--Outputs
   signal flag1 : std_logic;
   signal flag2 : std_logic;
   signal bits : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: manual PORT MAP (
          clk => clk,
          reset => reset,
          SW0 => SW0,
          SW1 => SW1,
          SW2 => SW2,
          SW3 => SW3,
          SW4 => SW4,
          SW5 => SW5,
          SW6 => SW6,
          SW7 => SW7,
          flag1 => flag1,
          flag2 => flag2,
          bits => bits
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset<='1';
      wait for 40 ns;
		reset <='0';
		SW0<='1';
		SW1<='0';
		SW2<='1';
		SW3<='1';
		SW4<='1';
      wait for clk_period*10;
		SW0<='0';
		SW1<='1';
		SW2<='0';
		SW3<='0';
		SW4<='0';
      wait for clk_period*10;
		SW0<='0';
		SW1<='1';
		SW2<='0';
		SW3<='1';
		SW5<='1';
      wait for clk_period*10;
		SW0<='0';
		SW1<='0';
		SW2<='1';
		SW3<='1';
		SW4<='1';
		SW5<='1';
      wait for clk_period*10;
		reset<='1';

      -- insert stimulus here 

      wait;
   end process;

END;
