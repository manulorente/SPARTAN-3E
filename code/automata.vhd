LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.STD_LOGIC_ARITH.ALL;

ENTITY automata IS
    PORT(
        clk, reset:        IN   std_logic;
        sensores:          IN   std_logic_vector(3 downto 0);
        pulsadores_eleg:   IN   std_logic_vector(3 downto 0);
        estadoPuerta:      IN   std_logic;
        
        abrirPuerta:       OUT  std_logic;
        motor:             OUT  std_logic_vector(1 downto 0)
    );
END automata;

ARCHITECTURE automata_arq OF automata IS
    TYPE ESTADOS is (reposo, cerrandoPuerta, moviendose, pulsoAbrirPuerta, esperaApertura);
    SIGNAL estado_actual, proximo_estado: estados;
BEGIN 
    --  ==================================================================================
    --  Proceso síncrono para actualizar estado
    --  ==================================================================================

       PROCESS (clk,reset)
    BEGIN
        IF (reset='0') THEN              
            estado_actual <= reposo;            -- Pasamos al estado de reposo
        ELSIF (rising_edge(clk)) THEN
              estado_actual<= proximo_estado;
        END IF;
    END PROCESS;
    
    --  ==================================================================================
    --  Proceso para la máquina de Moore
    --  ==================================================================================

    
    PROCESS(estado_actual,pulsadores_eleg,sensores,estadoPuerta)
   VARIABLE k: INTEGER RANGE 0 TO 3;
    begin
    k:=0;
    --Recordemos que de cerrar la puerta se encarga otro mortor, el pulso de abrir puerta sólo vale para abrir, no para cerrar
         CASE estado_actual IS
             WHEN reposo =>           
              	motor <="00"; --Motor parado=00 || motor bajar=01 || motor subir= 10
              	abrirPuerta <='0';	--No abrimos la puerta
              	IF (pulsadores_eleg="0000") THEN
              		proximo_estado <= reposo;
              	ELSE
              		proximo_estado <= cerrandoPuerta; 
              			for k in pulsadores_eleg'range
                		loop 
					IF (pulsadores_eleg(k) = sensores(k) and sensores(k)='1') THEN 
						    proximo_estado <= pulsoAbrirPuerta;
					 END IF;
				end loop;
             	END IF;
             WHEN cerrandoPuerta => 
              		IF (estadoPuerta='1') THEN  -- Abierta = 0. Cerrada = 1
				
					IF (pulsadores_eleg > sensores) THEN
						motor <= "10";
						proximo_estado <= moviendose;
					ELSIF (pulsadores_eleg < sensores) THEN 
						motor <= "01";
						proximo_estado <= moviendose;
					ELSE
						proximo_estado <= reposo;
					END IF;
					    IF sensores(0)='1' OR 
					   	(pulsadores_eleg(0)='0' AND sensores(1)='1') OR
					    	(pulsadores_eleg(0)='0' AND pulsadores_eleg(1)='0' 
					    				AND sensores(2)='1') THEN
						    motor<="10";
						    proximo_estado<=moviendose;
					    ELSE
						    motor<="01";
						    proximo_estado<=moviendose;
					    END IF;
			    	
				    IF sensores(3)='1' OR
				       (pulsadores_eleg(3)='0' AND sensores(2)='1') OR 
				       (pulsadores_eleg(3)='0' AND pulsadores_eleg(2)='0' 
				       AND sensores(1)='1') THEN
					    motor<="01";
					    proximo_estado<=moviendose;
				    ELSE
					    motor<="10";
					    proximo_estado<=moviendose;
				    END IF;
             		END IF;
                WHEN moviendose =>  
                	if (sensores="0000") then
                		proximo_estado <= moviendose;
                	elsif (pulsadores_eleg(0)=sensores(0) AND sensores(0)='1') OR
                		(pulsadores_eleg(1)=sensores(1) AND sensores(1)='1') OR
                		(pulsadores_eleg(2)=sensores(2) AND sensores(2)='1') OR
                		(pulsadores_eleg(3)=sensores(3) AND sensores(3)='1') THEN
                		motor <= "00";
                		proximo_estado<=pulsoAbrirPuerta;
                	ELSE
                		proximo_estado<= moviendose;
                	END IF;

                WHEN  pulsoAbrirPuerta=> 
                -- Pase lo que pase cambia de estado
                	abrirPuerta <='1';
                	proximo_estado <= esperaApertura;
		WHEN esperaApertura=>
			abrirPuerta <='0';
 		-- Este estado eqivale a esperaApertura. Si la puerta está cerrada mantiene el estado.
                   	IF (estadoPuerta='1') THEN -- Si no está abierta, mantiene el estado
                   		proximo_estado <= esperaApertura;
                   	ELSE
                   		proximo_estado <= reposo;
                   	END IF;
                WHEN OTHERS =>
                	proximo_estado<=reposo;
            END CASE;         
    END PROCESS;
    
END automata_arq;









































