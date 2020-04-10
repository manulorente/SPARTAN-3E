----------------------------------------------------------------------------------
-- Company: Sistemas electronicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    12:23:44 03/24/2015 
-- Design Name: 
-- Module Name:    gen_color - gen_color_arch 
-- Project Name: monitor_vga
-- Target Devices: 
-- Tool versions:
---------------------------------------------------------------------------------- 
-- Description: Bloque combinacional que asegura que el cañón de electronces esté apagado
-- cuando apunta fuera de la pantalla o está volviendo al comienzo de otra línea.
-- Se puede diseñar:
--	A. Como un bloque independiente, con la entidad especificada a continuación.
-- B. Como un proceso (con una sentencia if) en el nivel de jerarquía superior.
-- Blank_H,blank_V--> indicador de que está fuera de pantalla del comparador horiz o vertical
--	R_in, G_in, B_in--> entradas de color procedentes del bloque DIBUJA
-- R,G,B--> Salidas de color del controlador VGA.
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

entity gen_color is
    Port ( blank_h : in  STD_LOGIC;
           blank_v : in  STD_LOGIC;
           R_in : in  STD_LOGIC;
           G_in : in  STD_LOGIC;
           B_in : in  STD_LOGIC;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end gen_color;

architecture gen_color_arch of gen_color is

begin
-- Vamos a implementarlo con un process en el nivel de jerarquía superior.
process(Blank_H, Blank_V, R_in, G_in, B_in)
	begin
		if (Blank_H='1' or Blank_V='1') then
			R<='0'; G<='0'; B<='0';
		else
			R<=R_in; G<=G_in; B<=B_in;
		end if;
	end process;
	

end gen_color_arch;

