--------------------------------------------------------------------------------
-- Company: Sistemas electrónicos de comunicaciones
-- Engineer: Manuel Lorente Almán
--
-- Create Date:   12:39:13 03/27/2015
-- Design Name:   
-- Module Name:   C:/Users/manuel/Documents/ISE/monitor_vga/frec_pixel_tb.vhd
-- Project Name:  monitor_vga
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: frec_pixel
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
 
ENTITY frec_pixel_tb IS
END frec_pixel_tb;
 
ARCHITECTURE behavior OF frec_pixel_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT frec_pixel
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         clk_pixel : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal clk_pixel : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: frec_pixel PORT MAP (
          clk => clk,
          reset => reset,
          clk_pixel => clk_pixel
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
      wait for 100 ns;	
		reset<='0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
