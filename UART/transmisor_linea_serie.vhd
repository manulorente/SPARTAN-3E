----------------------------------------------------------------------------------
-- Company: Sistemas electrónicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    19:35:50 04/19/2015 
-- Design Name: 
-- Module Name:    transmisor_linea_serie - transmisor_linea_serie_arch 
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

entity transmisor_linea_serie is
Generic (ancho_bus_dir: integer :=4);
	 Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           TX : out  STD_LOGIC;
           button : in  STD_LOGIC);
end transmisor_linea_serie;

architecture transmisor_linea_serie_arch of transmisor_linea_serie is

COMPONENT miBlockRAM
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;


component fsm
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
	-- Pin de transmisión que va al conector DB9
end component;

signal dir_addr: STD_LOGIC_VECTOR (ancho_bus_dir-1 downto 0);
signal datarom_datafsm: std_logic_vector(7 downto 0);

begin

control_proceso_txon: fsm
		GENERIC MAP(ancho_bus_dir => 4,
						VAL_SAT_CONT=> 5208,
						ANCHO_CONTADOR=>13)
		PORT MAP (clk=> clk, rst=> rst, button=> button, 
		data=>datarom_datafsm, direcc=>dir_addr, TX=>TX);
		
memoria : miBlockRAM
  PORT MAP (
    clka => clk,
    addra => dir_addr,
    douta => datarom_datafsm);
  
end transmisor_linea_serie_arch;

