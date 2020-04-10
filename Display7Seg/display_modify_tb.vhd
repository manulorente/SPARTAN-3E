--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:18:36 04/02/2015
-- Design Name:   
-- Module Name:   C:/Users/manuel/Documents/ISE/display_7seg_modify/display_modify_tb.vhd
-- Project Name:  display_7seg_modify
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: control_display_p2
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
 
ENTITY display_modify_tb IS
END display_modify_tb;
 
ARCHITECTURE behavior OF display_modify_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT control_display_p2
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
         A : OUT  std_logic;
         B : OUT  std_logic;
         C : OUT  std_logic;
         D : OUT  std_logic;
         E : OUT  std_logic;
         F : OUT  std_logic;
         G : OUT  std_logic;
         DP : OUT  std_logic;
         AN : OUT  std_logic_vector(3 downto 0)
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
   signal A : std_logic;
   signal B : std_logic;
   signal C : std_logic;
   signal D : std_logic;
   signal E : std_logic;
   signal F : std_logic;
   signal G : std_logic;
   signal DP : std_logic;
   signal AN : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: control_display_p2 PORT MAP (
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
          A => A,
          B => B,
          C => C,
          D => D,
          E => E,
          F => F,
          G => G,
          DP => DP,
          AN => AN
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
      wait for clk_period*50;
		SW0<='0';
		SW1<='1';
		SW2<='0';
		SW3<='0';
		SW4<='0';
      wait for clk_period*50;
		SW0<='0';
		SW1<='1';
		SW2<='0';
		SW3<='1';
		SW5<='1';
		wait for clk_period*100;
		SW4<='0';
		SW5<='0';
      wait for clk_period*100000;
		SW0<='0';
		SW1<='0';
		SW2<='1';
		SW3<='1';
		SW4<='1';
		SW5<='1';
      wait for clk_period*50;
		reset<='1';

      -- insert stimulus here 

      wait;
   end process;

END;
