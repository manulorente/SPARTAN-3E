--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:51:44 04/06/2015
-- Design Name:   
-- Module Name:   C:/Users/manuel/Documents/ISE/monitor_vga_modify/boton_tb.vhd
-- Project Name:  monitor_vga_modify
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pulsador_contador
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
 
ENTITY boton_tb IS
END boton_tb;
 
ARCHITECTURE behavior OF boton_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pulsador_contador
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         BTN0 : IN  std_logic;
         pulsado : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal BTN0 : std_logic := '0';

 	--Outputs
   signal pulsado : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pulsador_contador PORT MAP (
          reset => reset,
          clk => clk,
          BTN0 => BTN0,
          pulsado => pulsado
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
		BTN0<='1';
		wait for 100 ns;
		reset<='0';
		BTN0<='0';
		wait for 100 ns;
		reset<='0';
		BTN0<='1';
		wait for 100 ns;
		reset<='0';
		BTN0<='0';
		wait for 100 ns;
		reset<='0';
		BTN0<='1';
		 wait for 100 ns;
		reset<='0';
		BTN0<='1';
		wait for 100 ns;
		reset<='1';
		BTN0<='1';
		wait for 100 ns;
		reset<='0';
		BTN0<='0';
		wait for 100 ns;
		reset<='0';
		BTN0<='1';
		wait for 100 ns;
		reset<='1';


      -- insert stimulus here 
   end process;

END;
