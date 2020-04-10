LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

--Declaración de la entidad
ENTITY test_ascensor IS
END    test_ascensor;

ARCHITECTURE test_ascensor_arq OF test_ascensor IS
    --Declaración de componentes
    COMPONENT ascensor
        PORT(
            clk, reset:   IN   std_logic;
            sensores:     IN   std_logic_vector(3 downto 0);
            pulsadores_c: IN   std_logic_vector(3 downto 0);
            pulsadores_p: IN   std_logic_vector(3 downto 0);
            estadoPuerta: IN   std_logic;
            abrirPuerta:  OUT  std_logic;
            display:      OUT  std_logic_vector(1 downto 0);
            motor:        OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;

    SIGNAL clk_tb, reset_tb:  std_logic;
    SIGNAL sensores_tb:       std_logic_vector(3 downto 0);
    SIGNAL pulsadores_c_tb:   std_logic_vector(3 downto 0);
    SIGNAL pulsadores_p_tb:   std_logic_vector(3 downto 0);
    SIGNAL estadoPuerta_tb:   std_logic;
    SIGNAL abrirPuerta_tb:    std_logic;
    SIGNAL display_tb:        std_logic_vector(1 downto 0);
    SIGNAL motor_tb:          std_logic_vector(1 downto 0);
    
    SIGNAL fin_tb:            std_logic := '0' ;          -- Indica fin de simulación. Se pone a '1' al final de la simulacion. 
    
    constant ciclo : time := 100 ns; 


BEGIN
    -- Se crea el componente del tipo 'ascensor' 
    -- Se conecta a las señales internas de la arquitectura
                                       -- --------              ------- 
    U1: ascensor          PORT MAP(    -- ascensor              test
                                       -- --------              ------- 
                                          clk          =>        clk_tb,
                                          reset        =>        reset_tb,
                                          sensores     =>        sensores_tb, 
                                          pulsadores_c =>        pulsadores_c_tb,
                                          pulsadores_p =>        pulsadores_p_tb,
                                          estadoPuerta =>        estadoPuerta_tb, 
                                          abrirPuerta  =>        abrirPuerta_tb, 
                                          display      =>        display_tb, 
                                          motor        =>        motor_tb 
                                     );


    -- -----------------------------
    --proceso que genera el reloj
    -- -----------------------------
    GenCLK: process
    begin
        if (fin_tb='1') THEN
            clk_tb<= '0';
            wait;
        ELSE
            clk_tb<= '0';      wait for ciclo/2;
            clk_tb<= '1';      wait for ciclo/2;
        END IF;
    end process GenCLK;
    
    
     -- -----------------------------
    --proceso que genera las entradas
    -- -----------------------------
    PROCESS
    BEGIN
        ---------------------------------
        -------- INICIALIZACION ---------
        ---------------------------------
        
        fin_tb <= '0';              -- deja pasar el reloj
        
        pulsadores_c_tb <= "0000";    -- Inicialmente ninguno pulsado
        pulsadores_p_tb <= "0000";    -- Inicialmente ninguno pulsado
        sensores_tb   <= "0010";    -- comenzamos en la planta 1
        reset_tb  <= '0';
        estadoPuerta_tb  <= '1';    -- puerta cerrada
            wait for 3*ciclo/4;     -- Nos situamos antes del flanco de bajada del reloj

       
        reset_tb <= '1';        -- reset='0'. Termina el reset
            wait for ciclo*2;
            
        ---------------------------------
        ----------- COMIENZO ------------  pulso uno -- otro y despues cierro
        ---------------------------------

        pulsadores_p_tb <= "0010";    -- Ir a la planta 1
            wait for ciclo*2;
            
        pulsadores_p_tb <= "0000";    -- Dejo de pulsar
            wait for ciclo*2;
            
        estadoPuerta_tb  <= '0';    -- Puerta abierta
            wait for ciclo*3;
            
        pulsadores_p_tb <= "0100";    -- Pulsamos planta 2
            wait for ciclo*2;
    
    pulsadores_p_tb <= "0000";    -- Dejamos de pulsar
            wait for ciclo*2;
         
         estadoPuerta_tb <= '1';    -- Puerta cerrada
            wait for ciclo;
        sensores_tb <= "0000";      -- Entreplanta
            wait for ciclo*2;
         pulsadores_p_tb <= "0001";   -- Pulsamos planta baja
            wait for ciclo*2;   
            
         pulsadores_p_tb <= "0000";   -- Dejo de pulsar
            wait for ciclo*2;   
               
        sensores_tb <= "0100";      -- Llegamos a la planta 2
            wait for ciclo*2;
            
        estadoPuerta_tb  <= '0';    -- Puerta abierta
            wait for ciclo*4;
            
        estadoPuerta_tb  <= '1';    -- Puerta cerrada
            wait for ciclo*2;
            
        sensores_tb <= "0000";      -- Pasamos por la entreplanta
            wait for ciclo*2;  
               
        sensores_tb <= "0010";      -- Pasamos por la planta 1
            wait for ciclo*2;   
            
        sensores_tb <= "0000";      -- Pasamos por la entreplanta
            wait for ciclo*2;  
                
        sensores_tb <= "0001";      -- Llegamos a la planta 0
            wait for ciclo*2;  
            
         estadoPuerta_tb <= '0';    -- Puerta abierta
            wait for ciclo*4;    
            
   
       fin_tb <= '1';
            wait;                 
    end process;
END test_ascensor_arq;



















