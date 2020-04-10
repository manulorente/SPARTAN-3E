----------------------------------------------------------------------------------
-- Company: Sistemas electrónicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    12:41:35 04/18/2015 
-- Design Name: 
-- Module Name:    fsm - fsm_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Circuito de control del proceso de transmisión
--
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


entity fsm is
	Generic (ancho_bus_dir: integer :=4;
	-- Indica el ancho del bus de direcciones de la memoria de la que se van a leer los datos
				VAL_SAT_CONT:integer:=20000;
	-- Valor en el que el contador alcanca los ciclos que debe durar la transmisión de un bit,
	-- depende de la velocidad de transmisión
				ANCHO_CONTADOR: integer:=20000);
	-- Número de líneas del contador que calcula el tiempo de bit. Debe ser suficiente para 
	-- alcanzar el valor de VAL_SAT_CONT
    Port ( clk : in STD_LOGIC;
			  rst : in  STD_LOGIC;
           button : in  STD_LOGIC;
	-- Inicia la transmisión de datos
           data : in  STD_LOGIC_VECTOR (7 downto 0);
           direcc : out  STD_LOGIC_VECTOR (ancho_bus_dir-1 downto 0);
			  TX: out STD_LOGIC);
	-- Pin de trnasmisión que va al conector DB9
end fsm;

architecture fsm_arch of fsm is
signal cont, p_cont: std_logic_vector(ANCHO_CONTADOR-1 downto 0);
-- Contador internos del número de ciclos para transmitir cada bit
signal dir, p_dir: std_logic_vector(ancho_bus_dir-1 downto 0);
-- Contador que se incrementa cada vez que se transmite un byte completo para generar la dirección correcta
TYPE ESTADOS is (reposo, inicio,test_data, b_start, b_0,b_1,b_2,b_3,b_4, b_5,b_6,b_7, b_paridad, b_stop);
SIGNAL estado_actual, proximo_estado: estados;

signal transmite: std_logic;	

	begin
	-- Vamos a hacer dos procesos; uno combinacional y otro síncrono.

	comb:process(cont,dir,data,button,estado_actual)
		begin
		p_dir<=dir;
		p_cont<=cont;
		-- Valores por defecto para evitar latches
		case estado_actual is
			when reposo =>
				p_dir<=(others => '0');
				p_cont<=(others => '0');
				transmite<='1';
				if (button='1') then
					proximo_estado<=inicio;
				else
					proximo_estado<=reposo;
				end if;
			when inicio =>
				transmite<='1';
				proximo_estado<=test_data;
			when test_data =>
				transmite<='1';
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) then
					if(data="00000000") then
						proximo_estado<=reposo;
						p_cont<=(others => '0');
					else
						proximo_estado<=b_start;
						p_cont<=(others => '0');
					end if;
				else
					proximo_estado<=test_data;
				end if;
			when b_start=>
				transmite<='0';
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) then
					p_cont<=(others => '0');
					proximo_estado<=b_0;
				else
				proximo_estado<=b_start;
				end if;
			when b_0 =>
				transmite<=data(0);
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) then
					p_cont<=(others => '0');
					proximo_estado<=b_1;
				else
				proximo_estado<=b_0;
				end if;
			when b_1 =>
				transmite<=data(1);
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) then
					p_cont<=(others => '0');
					proximo_estado<=b_2;
				else
				proximo_estado<=b_1;
				end if;
			when b_2 =>
				transmite<=data(2);
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) then
					p_cont<=(others => '0');
					proximo_estado<=b_3;
				else
				proximo_estado<=b_2;
				end if;
			when b_3 =>
				transmite<=data(3);
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) then
					p_cont<=(others => '0');
					proximo_estado<=b_4;
				else
				proximo_estado<=b_3;
				end if;
			when b_4 =>
				transmite<=data(4);
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) then
					p_cont<=(others => '0');
					proximo_estado<=b_5;
				else
				proximo_estado<=b_4;
				end if;
			when b_5 =>
				transmite<=data(5);
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) then
					p_cont<=(others => '0');
					proximo_estado<=b_6;
				else
				proximo_estado<=b_5;
				end if;
			when b_6 =>
				transmite<=data(6);
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) then
					p_cont<=(others => '0');
					proximo_estado<=b_7;
				else
				proximo_estado<=b_6;
				end if;
			when b_7 =>
				transmite<=data(7);
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) then
					p_cont<=(others => '0');
					proximo_estado<=b_paridad;
				else
				proximo_estado<=b_7;
				end if;
			when b_paridad =>
				transmite<= data(0) xor data(7)xor data(6)xor data(5)xor data(4)xor data(3)xor data(2)xor data(1)xor data(0);
				p_cont<=cont+1;
				p_dir<=dir;
				if (cont=VAL_SAT_CONT) THEN
					p_cont<=(others => '0');
					proximo_estado<=b_stop;
				else
				proximo_estado<=b_paridad;
				end if;
			when others=>
				transmite<='1';
				p_cont<=cont+1;
				if (cont=VAL_SAT_CONT) THEN
					p_cont<=(others => '0');
					p_dir<=dir+1;
					proximo_estado<=inicio;
				else
				proximo_estado<=b_stop;
				end if;
		end case;
	end process;

-- Actualizamos las salidas
	direcc<= dir;
	TX<= transmite;

	sinc:process(clk,rst)
		begin
		if (rst='1') then
			cont<=(others => '0');
			dir<=(others => '0');
			estado_actual<=reposo;
		elsif (rising_edge(clk)) then
			cont<= p_cont;
			dir<= p_dir;
			estado_actual<=proximo_estado;
		end if;
		end process;


end fsm_arch;

