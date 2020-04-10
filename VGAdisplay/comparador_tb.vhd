--------------------------------------------------------------------------------
-- Company: Sistemas electrónicos de comunicaciones
-- Engineer: Manuel Lorente Almán
--
-- Create Date:   14:24:19 03/20/2015
-- Design Name:   
-- Module Name:   C:/Users/manuel/Documents/ISE/monitor_vga/comparador_tb.vhd
-- Project Name:  monitor_vga
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comparador
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
USE ieee.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

 
ENTITY comparador_tb IS
END comparador_tb;
 
ARCHITECTURE behavior OF comparador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT comparador
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         data : IN  std_logic_vector(7 downto 0);
         O1 : OUT  std_logic;
         O2 : OUT  std_logic;
         O3 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal data : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal O1 : std_logic;
   signal O2 : std_logic;
   signal O3 : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: comparador PORT MAP (
          clk => clk,
          reset => reset,
          data => data,
          O1 => O1,
          O2 => O2,
          O3 => O3
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
		data<="11001101";
      wait for clk_period*6;
			data<="00001101";
      wait for clk_period*6;
			data<="00110011";
      wait for clk_period*6;
			data<="11100011";
      wait for clk_period*6;
			data<="00001111";
      wait for clk_period*6;

      -- insert stimulus here 

      wait;
   end process;

END;
