----------------------------------------------------------------------------------
-- Company: Sistemas electronicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    18:59:25 03/15/2015 
-- Design Name: 
-- Module Name:    cont_digito2 - cont_digito2_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--	El bloque es un contador sincrono con habilitación
--	Cuando esté activada la habilitación se contará de 0 a 9, volviendo a comenzar por 0
-- En cada flanco de subida incrementará el valor en 1
--	Satura cuando la cuenta sea de 67108863-->11111111111111111111111111(26) activa sat
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

entity cont_digito2 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           sat : out  STD_LOGIC;
           cuenta : out  STD_LOGIC_VECTOR (3 downto 0));
end cont_digito2;

architecture cont_digito2_arch of cont_digito2 is

signal salida, prox_cuenta: std_logic_vector(3 downto 0);
signal saturacion: std_logic;

	begin
	-- Vamos a hacer dos procesos; uno combinacional y otro síncrono.

	comb:process(salida,enable)
		begin
		if (salida=9 and enable='1') then
			prox_cuenta <= (others => '0');
			-- Si salida es 1001 ha llegado al 9 y hay que resetear
		elsif enable='1' then
			prox_cuenta<= salida + 1;
			saturacion<='0';
		else
		prox_cuenta<=salida;		
		saturacion<='0';
		end if;
		if (salida=9) then
			saturacion<='1';
		else
			saturacion<='0';
		end if;
	end process;
	cuenta<=salida;
	sat<=saturacion;
	
	sinc:process(clk,reset)
		begin
		if (reset='1') then
			salida<=(others => '0');
		elsif (rising_edge(clk)) then
			salida<= prox_cuenta;
		end if;
		end process;

end cont_digito2_arch;

