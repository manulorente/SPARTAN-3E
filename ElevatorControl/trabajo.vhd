LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ascensor IS
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
END ascensor;

ARCHITECTURE ascensor_arq OF ascensor IS

    COMPONENT automata
        PORT(
           clk, reset:        IN   std_logic;
           sensores:          IN   std_logic_vector(3 downto 0);
           pulsadores_eleg:   IN   std_logic_vector(3 downto 0);
           estadoPuerta:      IN   std_logic;
           abrirPuerta:       OUT  std_logic;
           motor:             OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    
    COMPONENT pulsadores_display
        PORT(
           clk,reset:       IN   std_logic;
           sensores:        IN   std_logic_vector(3 downto 0);
           pulsadores_c:    IN   std_logic_vector(3 downto 0);
           pulsadores_p:    IN   std_logic_vector(3 downto 0);
           display:         OUT  std_logic_vector(1 downto 0);
           pulsadores_eleg: OUT  std_logic_vector(3 downto 0)   
        );
    END COMPONENT;
    
    SIGNAL pulsadores_signal: std_logic_vector(3 downto 0);

BEGIN
                                       -- --------              -------- 
                                       -- autómata              ascensor
                                       -- --------              -------- 
   U1: automata           PORT MAP(        clk             =>   clk, 
                                           reset           =>   reset, 
                                           sensores        =>   sensores,  
                                           pulsadores_eleg =>   pulsadores_signal,    -- pulsadores_signal es interna de la arquitectura
                                           estadoPuerta    =>   estadoPuerta, 
                                           abrirPuerta     =>   abrirPuerta,
                                           motor           =>   motor
                                   );   
                                   
                                   
                                       -- -----------------     -------- 
                                       -- pulsadores+display    ascensor
                                       -- -----------------     -------- 
   U2: pulsadores_display PORT MAP(        clk             =>   clk, 
                                           reset           =>   reset, 
                                           sensores        =>   sensores,  
                                           pulsadores_c    =>   pulsadores_c, 
                                           pulsadores_p    =>   pulsadores_p, 
                                           display         =>   display,
                                           pulsadores_eleg =>   pulsadores_signal     -- pulsadores_signal es interna de la arquitectura
                                  );   
END ascensor_arq;




























