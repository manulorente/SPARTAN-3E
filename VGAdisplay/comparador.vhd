----------------------------------------------------------------------------------
-- Company: Sistemas electrónicos de comunicaciones
-- Engineer: Manuel Lorente Almán
-- 
-- Create Date:    13:27:00 03/20/2015 
-- Design Name: 
-- Module Name:    comparador - comparador_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--	Comparador síncrono, las salidas O1, O2, O3 cambiarán en los flancos positivos de reloj.
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

entity comparador is
	generic (Nbit: integer:=8;
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
end comparador;

architecture comparador_arch of comparador is
	signal p1,p2,p3,p1_sig,p2_sig,p3_sig : std_logic;
begin
	
	comb:process(data)
	begin
		if (data > End_Of_Screen) then
			p1_sig<='1';
		else
			p1_sig<='0';
		end if;
		if (Start_Of_Pulse< data and data< End_Of_Pulse) then
			p2_sig<='0';
		else
			p2_sig<='1';
		end if;
		if (data=End_Of_Line) then
			p3_sig<='1';
		else
			p3_sig<='0';
		end if;
	end process;
	
	sinc:process(clk,reset)
	begin
		if (reset='1') then
			p1<='0';
			p2<='0';
			p3<='0';
		elsif(rising_edge(clk)) then
			p1<=p1_sig;
			p2<=p2_sig;
			p3<=p3_sig;
		end if;	
	end process;

O1<=p1;
O2<=p2;
O3<=p3;

end comparador_arch;

