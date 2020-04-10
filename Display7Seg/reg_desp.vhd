----------------------------------------------------------------------------------
-- Company: Sistemas electrónicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    19:17:59 03/15/2015 
-- Design Name: 
-- Module Name:    reg_desp - reg_desp_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
----------------------------------------------------------------------------------
--	Registro de desplazamiento. El valor del registro al hacer un reset será 1110, 
--	la secuencia que se producirá será: 1110-->1101-->1011-->1110, solo se produce 
--	desplazamiento si el módulo está habilitado.
--	El valor del registro se utilizará para controlar señales de habilitación de los displays: aN3:0
--	Con enable='1', se produce un desplazamiento cada flanco positivo de reloj.
--		Todos los bits se desplazarán una posición a la izquierda hacia el más significativo.
--		El bit menos significativo pasa a tener el valor del más significativo.
----------------------------------------------------------------------------------------------
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_desp is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           display_enable : out  STD_LOGIC_VECTOR (3 downto 0));
end reg_desp;

architecture reg_desp_arch of reg_desp is

signal desplaza,prox_desplaza: std_logic_vector(3 downto 0);

	begin
	-- Vamos a hacer dos procesos; uno combinacional y otro síncrono.

	comb:process(desplaza,enable)
		begin
		if (enable='1') then
			CASE desplaza IS 
				WHEN "1110"=> prox_desplaza <="1101";
				WHEN "1101"=> prox_desplaza <="1011";
				WHEN "1011"=> prox_desplaza <="0111";
				WHEN OTHERS=> prox_desplaza <="1110"; 
			END CASE; 
		else
			prox_desplaza<=desplaza;
		end if;
	end process;
	display_enable<=desplaza;
	
	sinc:process(clk,reset)
		begin
		if (reset='1') then
			desplaza<= "1110";
		elsif (rising_edge(clk)) then
			desplaza<= prox_desplaza;
		end if;
		end process;

end reg_desp_arch;

