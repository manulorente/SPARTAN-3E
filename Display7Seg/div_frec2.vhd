----------------------------------------------------------------------------------
-- Company: Sistemas electronicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    18:25:12 03/15/2015 
-- Design Name: 
-- Module Name:    div_frec2 - div_frec2_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
------------------------------------------------------------------------------------------------------------
--El bloque se encargará de dividir la frecuencia por 2^26 para tener señal a 0.75MHz
--	Será un contador de 26 bits cuyo valor de cuenta se almacenará en un registro de 26 bits llamado cuenta.
-- En cada flanco de subida incrementará el valor en 1
--	Satura cuando la cuenta sea de 67108863-->11111111111111111111111111(26)
--	Satura2 cuando la cuenta sea de 255-->11111111 
------------------------------------------------------------------------------------------------------------
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

entity div_frec2 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           sat : out  STD_LOGIC;
           sat2 : out  STD_LOGIC);
end div_frec2;

architecture div_frec2_arch of div_frec2 is
		signal cuenta,cuenta2,prox_cuenta2, prox_cuenta: std_logic_vector(25 downto 0);
		signal saturacion1,saturacion2: std_logic;
	begin
	-- Vamos a hacer dos procesos; uno combinacional y otro síncrono.
	comb:process(cuenta,cuenta2)
		begin	--2048(100000000000) para simular y al implementar es 26x1 y debemos cambiar la longitud del vector
		-- MUY IMPORTANTE CAMBIAR LONGITUD DEL VECTOR
			--11111111111111111111111111
		if (cuenta="11111111111111111111111111") then
			--Final de la cuenta
				saturacion1<='1';
				saturacion2<='1';
				prox_cuenta<= (others => '0');
				prox_cuenta2<= (others => '0');
		elsif (cuenta2="11111111") then
			saturacion2<='1';
			saturacion1<='0';
			prox_cuenta <= cuenta + 1;
			prox_cuenta2<= (others => '0');
		else
			prox_cuenta <= cuenta + 1;
			prox_cuenta2<= cuenta2 + 1;
			saturacion2<='0';
			saturacion1<='0';
		end if;
	

		
		end process;
	sat<=saturacion1;
	sat2<=saturacion2;

	sinc:process(clk,reset)
		begin
		if (reset='1') then
			cuenta<= (others => '0');
			cuenta2<= (others => '0');
		elsif (rising_edge(clk)) then
			cuenta<= prox_cuenta;
			cuenta2<= prox_cuenta2;
		end if;
		end process;

end div_frec2_arch;




