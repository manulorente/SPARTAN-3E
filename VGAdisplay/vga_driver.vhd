----------------------------------------------------------------------------------
-- Company: Sistemas electrónicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    12:45:41 03/24/2015 
-- Design Name: 
-- Module Name:    vga_driver - vga_drive_arch 
-- Project Name: monitor_vga
-- Target Devices: 
-- Tool versions:
----------------------------------------------------------------------------------
-- Description: Nivel de jerarquía superior, el valor de los generics es:
--	Conth: Nbit=10
--	Contv: Nbit=10
--	Comph: Nbit=10, End_Of_Screen=639, Start_Of_Pulse=655, End_Of_Pulse= 751, End_Of_Line=799
--	Compv: Nbit=10, End_Of_Screen=479, Start_Of_Pulse=489, End_Of_Pulse= 491, End_Of_Line=520
--	Descripción de los puertos:
--	clk, reset--> reloj de entrada y reset asíncrono activo a nivel alto
--	VS,HS--> sincronismo vertical y horizontal
--	R,G,B-->Rojo, verde, azul
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

entity vga_driver is
				
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  SW0 : in  STD_LOGIC;
			  BTN0 : in STD_LOGIC;
           VS : out  STD_LOGIC;
           HS : out  STD_LOGIC;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
			  
end vga_driver;

architecture vga_drive_arch of vga_driver is
 --Declaración de componentes
    COMPONENT frec_pixel
    Port (  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk_pixel : out  STD_LOGIC);
    END COMPONENT;
	 
	 COMPONENT contador
	 generic (Nbit: integer := 10);
    Port ( clk : in  STD_LOGIC;
           resets : in  STD_LOGIC;
			  reset	: in std_logic;
			  enable	: in std_logic;
           Q: out  STD_LOGIC_VECTOR(Nbit-1 downto 0));
    END COMPONENT;
	 
	 COMPONENT comparador
	 generic (Nbit: integer:=10;
				End_Of_Screen: integer:= 10;
				Start_Of_Pulse: integer := 20;
				End_Of_Pulse: integer :=30;
				End_Of_Line:	integer := 40);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
				data : in  STD_LOGIC_VECTOR (Nbit-1 downto 0);
           O1 : out  STD_LOGIC;
           O2 : out  STD_LOGIC;
           O3 : out  STD_LOGIC);
    END COMPONENT;
	 
	 COMPONENT dibuja 
	 generic (Nbit: integer := 10);
	 
	 Port ( eje_x : in  STD_LOGIC_VECTOR (Nbit-1 downto 0);
           eje_y : in  STD_LOGIC_VECTOR (Nbit-1 downto 0);
			  SW0 : in std_logic;
			  cambio: in std_logic_vector (1 downto 0);
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
	 END COMPONENT;
	 
	 COMPONENT gen_color 
    Port ( blank_h : in  STD_LOGIC;
           blank_v : in  STD_LOGIC;
           R_in : in  STD_LOGIC;
           G_in : in  STD_LOGIC;
           B_in : in  STD_LOGIC;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
	end COMPONENT;
	
	component pulsador_contador
    Port ( clk: in std_logic;
			  reset : in  STD_LOGIC;
           BTN0 : in  STD_LOGIC;
           pulsado : out  STD_LOGIC_VECTOR (1 downto 0));
	end component;
	 	 
	 signal pixel_enable1, enable2, O3_enable1, O3_enable2 : std_logic;
	 signal O1_blankh, O2_HS, O1_blankv, O2_VS, R_Rin, G_Gin, B_Bin, R_out, B_out, G_out : std_logic;
	 signal Q_data1, Q_data2 : std_logic_vector(9 downto 0);
	 signal pulsador: std_logic_vector(1 downto 0);
	
begin
    -- Se crean los componentes
    -- Se conecta a las señales internas de la arquitectura
	 
	 frecuencia_pixel: frec_pixel PORT MAP(clk=>clk, reset=>reset,clk_pixel=> pixel_enable1);
	 	
	 boton_pulsador: pulsador_contador 
	 PORT MAP(clk=>clk,reset=>reset, BTN0=>BTN0, pulsado=>pulsador);
		
	 conth: contador 
		generic map (Nbit=>10)
	 PORT MAP( clk=>clk, reset=>reset, resets=> O3_enable1, enable=> pixel_enable1, Q=>Q_data1);
	 
	 contv: contador 
		generic map (Nbit=>10)
	 PORT MAP( clk=>clk, reset=>reset, resets=> O3_enable2, enable=> enable2, Q=>Q_data2);
	
	 comph: comparador
		GENERIC MAP(Nbit => 10,
						End_Of_Screen=> 639,
						Start_Of_Pulse=> 655,
						End_Of_Pulse=> 751,
						End_Of_Line=>799)
		PORT MAP (clk=> clk, reset=> reset, data=> Q_data1, O1=>O1_blankh, O2=>O2_HS, O3=>O3_enable1);
		
	 compv: comparador 
		GENERIC MAP(Nbit => 10,
						End_Of_Screen=> 479,
						Start_Of_Pulse=> 489,
						End_Of_Pulse=> 491,
						End_Of_Line=>520)
	 PORT MAP (clk=> clk, reset=> reset, data=> Q_data2, O1=>O1_blankv, O2=>O2_VS, O3=>O3_enable2);
	 
	 dibujo: dibuja 
		GENERIC MAP(Nbit => 10)
	 PORT MAP(eje_x=>Q_data1, eje_y=> Q_data2, R=>R_Rin, G=>G_Gin, B=>B_Bin,SW0=>SW0,cambio=>pulsador);
	 
	 generador: gen_color 
	 PORT MAP(blank_h=>O1_blankh, blank_v=>O1_blankv, R_in=>R_Rin, B_in=>B_Bin, G_in=>G_Gin, R=>R_out, G=>G_out, B=>B_out);

	 enable2 <= (pixel_enable1 AND O3_enable1);

	--Debemos asignar cada bit de salida a un pin

	HS<=O2_HS;
	VS<=O2_VS;
	R<=R_out;
	G<=G_out;
	B<=B_out;

end vga_drive_arch;

	 