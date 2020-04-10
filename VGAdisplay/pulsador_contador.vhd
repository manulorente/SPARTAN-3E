----------------------------------------------------------------------------------
-- Company: Sistemas electronicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    14:57:57 04/02/2015 
-- Design Name: 
-- Module Name:    pulsador_contador - pulsador_contador_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pulsador_contador is
    Port ( reset : in  STD_LOGIC;
			  clk: in std_logic;
           BTN0 : in  STD_LOGIC;
           pulsado : out  STD_LOGIC_VECTOR (1 downto 0));
end pulsador_contador;

architecture pulsador_contador_arch of pulsador_contador is
	TYPE ESTADOS is (reposo, contando, espera_bajada);
   SIGNAL estado_actual, proximo_estado: estados;
	signal salida, prox_cuenta: std_logic_vector(1 downto 0);
BEGIN 
    --  ==================================================================================
    --  Proceso síncrono para actualizar estado
    --  ==================================================================================

  sinc:PROCESS (clk,reset)
		 BEGIN
			  IF (reset='1') THEN              
					estado_actual <= reposo;            -- Pasamos al estado de reposo
					salida<=(others => '0');
			 ELSIF (rising_edge(clk)) THEN
					estado_actual<= proximo_estado;
					salida<= prox_cuenta;
			  END IF;
		 END PROCESS;	
	
	pulsado<=salida;
	
	autom:PROCESS(estado_actual,BTN0,salida)
    begin
	 case estado_actual is
          WHEN reposo =>
				if BTN0='0' then
					proximo_estado<=reposo;
					prox_cuenta<=salida;	
				else
					proximo_estado<=contando;
					prox_cuenta<=salida;	
				end if;
			 WHEN contando =>
					if (salida = "10") then
						prox_cuenta<= (others => '0');
					else
						prox_cuenta<= salida + 1;
					end if;
					proximo_estado<= espera_bajada;
          WHEN OTHERS =>	-- Equivale a espera_bajada
            if (BTN0='0') then
					proximo_estado<=reposo;
					prox_cuenta<=salida;	
				else
					proximo_estado<= espera_bajada;
					prox_cuenta<=salida;	
				end if;
         END CASE; 
	end process;
		
end pulsador_contador_arch;

