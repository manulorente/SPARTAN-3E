----------------------------------------------------------------------------------
-- Company: Sistemas electrónicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    11:28:44 04/02/2015 
-- Design Name: 
-- Module Name:    manual - manual_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions:
---------------------------------------------------------------------------------- 
-- Description: Modificación que consiste en leer los switches y los 4 primeros
-- (SW0 SW1 SW2 SW3) indican un valor que dependiendo de los siguientes se usa para
--	una cosa u otra.
--	SW4 y 5='1'--> la cuenta se mantiene hasta que se baja la palanca
--	SW6 y 7='1'--> la cuenta se mantiene en el display pero sigue internamente y luego muestra por donde va
-- Lo siguiente ya sería si lo anterior funcionaba
--	SW6='1'--> precarga de los contadores e incrementa.
--	SW7='1'--> precarga de los contadores y decrementa.
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity manual is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           SW0 : in  STD_LOGIC;
           SW1 : in  STD_LOGIC;
           SW2 : in  STD_LOGIC;
           SW3 : in  STD_LOGIC;
           SW4 : in  STD_LOGIC;
           SW5 : in  STD_LOGIC;
           SW6 : in  STD_LOGIC;
           SW7 : in  STD_LOGIC;
           flag1 : out  STD_LOGIC;
           flag2 : out  STD_LOGIC;
           bits: out std_logic_vector(3 downto 0));
end manual;

architecture manual_arch of manual is

signal bit_salida, pbit_salida: std_logic_vector(3 downto 0);
signal bandera1, bandera2, pbandera1, pbandera2: std_logic;

	begin
	-- Vamos a hacer dos procesos; uno combinacional y otro síncrono.

	comb:process(bit_salida,SW0,SW1,SW2,SW3,SW4,SW5,SW6,SW7)
		begin
		pbandera1<='0';
		pbandera2<='0';
		pbit_salida(0)<= SW0;
		pbit_salida(1)<= SW1;
		pbit_salida(2)<= SW2;
		pbit_salida(3)<= SW3;
		if (SW4='1' or SW5='1') then
			pbandera1<='1';
			pbandera2<='0';
		end if;
		if (SW6='1' or SW7='1') then
			pbandera2<='1';
			pbandera1<='0';
		end if;
		
	end process;
	
	sinc:process(clk,reset)
		begin
		if (reset='1') then
			bit_salida <= (others => '0');
			bandera1<='0';
			bandera2<='0';
		elsif (rising_edge(clk)) then
				bit_salida<=pbit_salida;
				bandera1<= pbandera1;
				bandera2<= pbandera2;
		end if;
		end process;
		
flag1<=bandera1;
flag2<=bandera2;
bits<=bit_salida;

end manual_arch;

