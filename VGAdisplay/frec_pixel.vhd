----------------------------------------------------------------------------------
-- Company: Sistemas electr�nicos de comunicaciones
-- Engineer: Manuel Lorente Alm�n
-- 
-- Create Date:    12:38:27 03/24/2015 
-- Design Name: 
-- Module Name:    frec_pixel - frec_pixel_arch 
-- Project Name: monitor_vga
-- Target Devices: 
-- Tool versions: 
----------------------------------------------------------------------------------
-- Description: Divide por dos la frecuencia de reloj, produciendo en su salida una se�al
-- de 25 MHz.
--	Lo dise�aremos como un process s�ncrono en el nivel de jerarqu�a superior.
--	clk_pixel es la se�al generada de 25MHz.
----------------------------------------------------------------------------------
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frec_pixel is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk_pixel : out  STD_LOGIC);
end frec_pixel;

architecture frec_pixel_arch of frec_pixel is
signal clk_pixel_act: std_logic;
begin
-- Lo comentamos para a�adirlo posteriormente al bloque de jerarqu�a superior.
	process(clk,reset)
		begin
		if (reset='1') then
		clk_pixel_act<='0';
		elsif (rising_edge(clk)) then
		clk_pixel_act<= not clk_pixel_act;
		end if;
	end process;
clk_pixel<=clk_pixel_act;
end frec_pixel_arch;

