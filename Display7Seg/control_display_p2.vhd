----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:08:44 03/15/2015 
-- Design Name: 
-- Module Name:    control_display_p2 - control_display_p2_arch 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_display_p2 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  SW0 : in  STD_LOGIC;
           SW1 : in  STD_LOGIC;
           SW2 : in  STD_LOGIC;
           SW3 : in  STD_LOGIC;
           SW4 : in  STD_LOGIC;
           SW5 : in  STD_LOGIC;
           SW6 : in  STD_LOGIC;
           SW7 : in  STD_LOGIC;
           A : out  STD_LOGIC;
           B : out  STD_LOGIC;
           C : out  STD_LOGIC;
           D : out  STD_LOGIC;
           E : out  STD_LOGIC;
           F : out  STD_LOGIC;
           G : out  STD_LOGIC;
           DP : out  STD_LOGIC;
           AN : out  STD_LOGIC_VECTOR (3 downto 0));
end control_display_p2;


architecture control_display_p2_arch of control_display_p2 is

 --Declaración de componentes
    COMPONENT cont_digito2
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  sat		: out std_logic;
           cuenta : out  STD_LOGIC_VECTOR(3 downto 0));
    END COMPONENT;
	 
	 COMPONENT div_frec2
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  sat2	: out std_logic;
           sat : out  STD_LOGIC);
    END COMPONENT;
	 
	 COMPONENT decodificador
    Port ( binario : in  STD_LOGIC_VECTOR (3 downto 0);
           siete_seg : out  STD_LOGIC_VECTOR (6 downto 0));
    END COMPONENT;
	 
	 COMPONENT reg_desp
	 Port	( clk	:in	std_logic;
				reset:	in	std_logic;
				enable:	in	std_logic;
				display_enable:	out std_logic_vector(3 downto 0));
	 END COMPONENT;
	 
	 component manual
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           SW0 : in  STD_LOGIC;
           SW1 : in  STD_LOGIC;
           SW2 : in  STD_LOGIC;
           SW3 : in  STD_LOGIC;
           SW4 : in  STD_LOGIC;
           SW5 : in  STD_LOGIC;
           SW6 : in  STD_LOGIC;
           SW7 : in  STD_LOGIC;
           flag1 : out  STD_LOGIC;
           flag2 : out  STD_LOGIC;
           bits: out std_logic_vector(3 downto 0));
		end component;
	 
	 signal sat1_enable, sat2_enable,sat_cont1,sat_cont2,sat_cont3: std_logic;
	 signal enable1, enable2,enable3,enable4, flag1_int,flag2_int, activa_mux: std_logic;
	 signal cuenta_a,cuenta_b,cuenta_c,cuenta_d,enable_sel,salida_mux, entrada_decod, bits_int: std_logic_vector(3 downto 0);
	 signal sieteseg_salida: std_logic_vector(6 downto 0);
	
begin
    -- Se crean los componentes
    -- Se conecta a las señales internas de la arquitectura
	 
	 divisor_frecuencia: div_frec2 PORT MAP(clk=>clk, reset=>reset,sat=>sat1_enable,sat2=>sat2_enable);
	 	 
	 contador1: cont_digito2 PORT MAP( clk=>clk, reset=>reset, enable=>enable1, sat=>sat_cont1,cuenta=>cuenta_a);
	 contador2: cont_digito2 PORT MAP( clk=>clk, reset=>reset, enable=>enable2 , sat=>sat_cont2  ,cuenta=>cuenta_b);
	 contador3: cont_digito2 PORT MAP( clk=>clk, reset=>reset, enable=>enable3 , sat=>sat_cont3 ,cuenta=>cuenta_c);
	 contador4: cont_digito2 PORT MAP( clk=>clk ,reset=>reset, enable=>enable4, sat=>OPEN,cuenta=>cuenta_d);
	 
	 palancas: manual PORT MAP (clk=>clk, reset=> reset,SW0=>SW0,SW1=>SW1,SW2=>SW2,SW3=>SW3,SW4=>SW4,SW5=>SW5,SW6=>SW6,
	 SW7=>SW7,flag1=>flag1_int, flag2=> flag2_int, bits=>bits_int);
	 
	 decod_bin7seg: decodificador PORT MAP(binario=>entrada_decod,siete_seg=>sieteseg_salida);
	 
	 registro:	reg_desp	PORT MAP(clk=>clk,reset=>reset,enable=>sat2_enable,display_enable=>enable_sel);
	 
	 enable1 <= (sat1_enable AND not(flag1_int));
	 enable2 <= (sat1_enable AND sat_cont1 AND not(flag1_int));
	 enable3 <= (enable2 AND sat_cont2 AND not(flag1_int));
	 enable4 <= (enable3 AND sat_cont3 AND not(flag1_int));
	 
	 -- Implementamos multiplexor con ayuda de las señales internas

    salida_mux<=  cuenta_a WHEN (enable_sel="1110") ELSE 
						cuenta_b WHEN (enable_sel="1101") ELSE
						cuenta_c WHEN (enable_sel="1011") ELSE
						cuenta_d;
	 
	 activa_mux<= (flag1_int OR flag2_int);
	 
	 entrada_decod<= salida_mux when (activa_mux ='0') ELSE
						  bits_int;
						  
	 --Debemos asignar cada bit de salida a un pin

	A<= sieteseg_salida(6);
	B<= sieteseg_salida(5);
	C<= sieteseg_salida(4);
	D<= sieteseg_salida(3);
	E<= sieteseg_salida(2);
	F<= sieteseg_salida(1);
	G<= sieteseg_salida(0);
	
	--Desactivamos el punto del display 
	DP<='1';
	
	--Vemos el display que encendemos con un 0
	-- No estoy seguro si esta orden es necesaria o basta con la instancia unir los cables
	AN<=enable_sel;


end control_display_p2_arch;

