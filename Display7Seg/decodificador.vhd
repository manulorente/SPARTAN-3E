----------------------------------------------------------------------------------
-- Company: Sistemas electrónicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    19:46:24 03/12/2015 
-- Design Name: 
-- Module Name:    decodificador - decodificador_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
-------------------------------------------------------------------------------------
--	 Este bloque es combinacional y produce el código correcto para la activación del display
--  de 7 segmentos a partir del número binario de 4 bits.
--	 El código de 7 segmentos, se corresponde de más a menos significativo con las entradas del display:
--	 A,B,C,D,E,F,y G
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments:
-- Los reset asíncrono van en el proceso síncrono y los síncronos en el proceso 
	-- combinacional, este es asíncrono por lo que va en el combinacional, idem con enable 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decodificador is
    Port ( binario : in  STD_LOGIC_VECTOR (3 downto 0);
           siete_seg : out  STD_LOGIC_VECTOR (6 downto 0));
end decodificador;

architecture decodificador_arch of decodificador is
	signal aux :STD_LOGIC_VECTOR (6 downto 0);
	begin
	
	comb:process(binario)
		BEGIN 
			CASE binario IS 
				WHEN "0000"=> aux <="0000001"; -- '0'
				WHEN "0001"=> aux  <="1001111"; -- '1' 
				WHEN "0010"=> aux  <="0010010"; -- '2' 
				WHEN "0011"=> aux  <="0000110"; -- '3' 
				WHEN "0100"=> aux  <="1001100"; -- '4' 
				WHEN "0101"=> aux  <="0100100"; -- '5' 
				WHEN "0110"=> aux  <="0100000"; -- '6' 
				WHEN "0111"=> aux  <="0001111"; -- '7' 
				WHEN "1000"=> aux  <="0000000"; -- '8' 
				WHEN "1001"=> aux  <="0000100"; -- '9' 
				-- si la entrada 'bcd' supera el número 9 se apagan los segmentos
				WHEN OTHERS=> aux <="1111111"; 
			END CASE; 
	end process;
	
	siete_seg<=aux;
	
end decodificador_arch;

