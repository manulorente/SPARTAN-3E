LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY pulsadores_display IS
    PORT(
        clk,reset:       IN   std_logic;
        sensores:        IN   std_logic_vector(3 downto 0);
        pulsadores_c:    IN   std_logic_vector(3 downto 0);
        pulsadores_p:    IN   std_logic_vector(3 downto 0);
        
        display:         OUT  std_logic_vector(1 downto 0);
        pulsadores_eleg: OUT  std_logic_vector(3 downto 0)   -- Registro que memoriza el pulsador elegido
    );
END pulsadores_display;

ARCHITECTURE pulsadores_display_arq OF pulsadores_display IS

    SIGNAL pisos_eleg: std_logic_vector(3 downto 0);   -- Captura del pulsador elegido  

BEGIN
    --  ==========================================
    --  Proceso para asignar la salida "display"
    --  ==========================================
    ActualizaDisplay:PROCESS (clk,reset,sensores)
    BEGIN
    	IF (reset='0') THEN         
            display<= "00";             -- Ponemos a cero el display
        ELSIF (rising_edge(clk)) THEN 
       -- Si el sensor del piso x está activo se activa en binario el display, 
          IF (sensores(0)='1') THEN
          	display <= "00";
          ELSIF (sensores(1)='1') THEN
          	display <= "01";
          ELSIF (sensores(2)='1') THEN
          	display <= "10";
          ELSIF (sensores(3)='1') THEN
          	display <= "11";
          END IF;
        END IF;
    END PROCESS ActualizaDisplay;
    
    
    
    --  ===================================================
    --  Proceso para asignar la señal interna "pisos_eleg"
    --  ===================================================
    PROCESS (clk,reset)
    VARIABLE k: INTEGER RANGE 0 TO 3;
    BEGIN
        IF (reset='0') THEN         -- Si se pulsa reset
            pisos_eleg <= "0000";       -- Ponemos a cero el pulsador
            
        ELSIF (rising_edge(clk)) THEN  -- En otro caso ante cualquier flanco de subida
        	k:=0;
       		FOR k IN pulsadores_c'RANGE 
         	LOOP
        		IF(((pulsadores_c(k)='1') or (pulsadores_p(k)='1'))) THEN
        			pisos_eleg(k) <= '1';
        			
        		ELSIF (((pisos_eleg(k)='1') or (pisos_eleg(k)='1')) AND (sensores(k)='1')) THEN
        			pisos_eleg(k) <= '0';
        		END IF;
        	END LOOP;
        END IF;
    END PROCESS;

    --  ==================================================================================
    --  Asignacion de los valores actuales a los valores de salida de manera concurrente 
    --  ==================================================================================
    pulsadores_eleg <= pisos_eleg;
    
END pulsadores_display_arq;












































