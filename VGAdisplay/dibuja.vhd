----------------------------------------------------------------------------------
-- Company: Sistemas electrónicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    11:47:48 03/24/2015 
-- Design Name: 
-- Module Name:    dibuja - dibuja_arch 
-- Project Name: monitor_vga
-- Target Devices: 
-- Tool versions:
----------------------------------------------------------------------------------- 
-- Description: 
-- Bloque combinacional que generaá, a partir de las coordenadas de pantall (eje_x,eje_y),
-- las salidas de color necesarias (R,G,B) para producir una imagen.
-- eje_x--> coordenada horizonal del píxel, comprendidas entre 0 y 639.
-- eje_y--> coordenada vertical del píxel, comprendidas entre 0 y 479.
-- R,G y B--> salida de color rojo,verde y azul respectivamente.
-----------------------------------------------------------------------------------
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

entity dibuja is
generic (Nbit: integer := 10);
    Port ( eje_x : in  STD_LOGIC_VECTOR (Nbit-1 downto 0);
           eje_y : in  STD_LOGIC_VECTOR (Nbit-1 downto 0);
			  SW0 : in std_logic;
			  cambio: in std_logic_vector (1 downto 0);
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end dibuja;

architecture dibuja_arch of dibuja is

begin
	process(eje_x,eje_y,SW0,cambio)
	begin
		G<='1'; R<='1'; B<='1'; --Pone pantalla en blanco
		if (SW0='1') then
			if ((eje_x>160 and eje_x<480) and (eje_y>60 and eje_y<422)) then --Borde del semáforo
					if (cambio="00") then --rojo
						if (eje_x>200 and eje_x<440)then
							if (eje_y>80 and eje_y<174) then
									R<='1';G<='0';B<='0';
							elsif (eje_y>194 and eje_y<288) then
									R<='0';G<='1';B<='1';
							elsif (eje_y>308 and eje_y<402) then
									R<='0';G<='1';B<='1';
							else
								R<='0';G<='0';B<='0';
							end if;
						else
							R<='0';G<='0';B<='0';
						end if;
						
					elsif (cambio="01") then --amarillo
						if (eje_x>200 and eje_x<440)then
								if (eje_y>80 and eje_y<174) then
										R<='0';G<='1';B<='1';
								elsif (eje_y>194 and eje_y<288) then
										R<='1';G<='1';B<='0';
								elsif (eje_y>308 and eje_y<402) then
										R<='0';G<='1';B<='1';
								else
									R<='0';G<='0';B<='0';
								end if;
							else
								R<='0';G<='0';B<='0';
							end if;
					elsif (cambio="10") then	--verde
						if (eje_x>200 and eje_x<440)then
								if (eje_y>80 and eje_y<174) then
										R<='0';G<='1';B<='1';
								elsif (eje_y>194 and eje_y<288) then
										R<='0';G<='1';B<='1';
								elsif (eje_y>308 and eje_y<402) then
										R<='0';G<='1';B<='0';
								else
									R<='0';G<='0';B<='0';
								end if;
							else
								R<='0';G<='0';B<='0';
							end if;
						end if;
			else
				G<='1'; R<='1'; B<='1'; --Pone pantalla en blanco
			end if;
		else -- si la palanca esta inactiva pues sale bandera
			if ((eje_x>279 and eje_x<359) or (eje_y>209 and eje_y<269)) then
				R<='1';G<='0';B<='0';
			end if;
		end if;
	end process;
	
end dibuja_arch;

