----------------------------------------------------------------------------------
-- Company: Sistemas electr�nicos de comunicaciones
-- Engineer: Manuel Lorente Alm�n
-- 
-- Create Date:    12:21:23 03/20/2015 
-- Design Name: 
-- Module Name:    contador - contador_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:
----------------------------------------------------------------------------------
-- Contador s�ncrono de Nbit con habilitaci�n y reset s�ncrono. 
-- El contador tiene un reset as�ncrono a nivel alto y otro s�ncrono a nivel alto.
-- Si resets='1' el contador pasar� a cero en el siguiente flanco positivo de reloj.
--	Enable--> se�al de habilitaci�n activa a nivel alto. Si enable='1' el contador
--	avanzar� a uno en la cuenta en el flanco positivo de reloj.
--	Q es la salida de Nbit igual al valor de la cuenta.
------------------------------------------------------------------------------------
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

entity contador is
	generic (Nbit: integer := 10);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           resets : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (Nbit-1 downto 0));
end contador;

architecture contador_arch of contador is

signal salida, prox_cuenta: std_logic_vector(Nbit-1 downto 0);


	begin
	-- Vamos a hacer dos procesos; uno combinacional y otro s�ncrono.

	comb:process(salida,enable,resets)
		begin
		if (resets='1') then
			prox_cuenta <= (others => '0');
		elsif enable='1' then
			prox_cuenta<= salida + 1;
		else
		prox_cuenta<=salida;		
		end if;
	end process;
	Q<=salida;

	
	sinc:process(clk,reset)
		begin
		if (reset='1') then
			salida<=(others => '0');
		elsif (rising_edge(clk)) then
			salida<= prox_cuenta;
		end if;
		end process;

end contador_arch;

