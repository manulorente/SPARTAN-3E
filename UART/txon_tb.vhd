--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:02:09 04/19/2015
-- Design Name:   
-- Module Name:   /home/hugh/ISE_Xilinx/projects/transmision_linea_serie/txon_tb.vhd
-- Project Name:  transmision_linea_serie
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: transmisor_linea_serie
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
 
ENTITY txon_tb IS
END txon_tb;
 
ARCHITECTURE behavior OF txon_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT transmisor_linea_serie
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         TX : OUT  std_logic;
         button : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal button : std_logic := '0';

 	--Outputs
   signal TX : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: transmisor_linea_serie PORT MAP (
          clk => clk,
          rst => rst,
          TX => TX,
          button => button
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
      rst<='1';
		wait for 100 ns;	
		rst<='0';
		button<='1';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
