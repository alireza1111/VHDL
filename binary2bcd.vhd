----------------------------------------------------------------------------------
-- Company: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bin2bcd is
       port(input1 : in STD_LOGIC_VECTOR(8 downto 0);
		      input2 : in STD_LOGIC_VECTOR(8 downto 0);
		 hundreds : out  STD_LOGIC_VECTOR(3 downto 0);
       tens : out  STD_LOGIC_VECTOR(3 downto 0);
       unit : out  STD_LOGIC_VECTOR(3 downto 0);
		 hundreds_bcd : out  STD_LOGIC_VECTOR(3 downto 0);
       tens_bcd : out  STD_LOGIC_VECTOR(3 downto 0);
       unit_bcd : out  STD_LOGIC_VECTOR(3 downto 0));

end bin2bcd;

architecture Behavioral of bin2bcd is   			
begin

process(input1)
				variable i : integer:=0; 
				variable bcd : std_logic_vector(20 downto 0);-- reserving space for converting binary to bcd
begin 
				bcd := (others => '0');
				bcd(8 downto 0) := input1;-- output value of sensor 1
		for i in 0 to 8 loop 
--double dabble algorithm for binary to BCD
			bcd(19 downto 0) := bcd(18 downto 0) & '0';


		if(i < 8 and bcd(12 downto 9) > "0100") then
			bcd(12 downto 9) := bcd(12 downto 9) + "0011";
		end if;
		if(i < 8 and bcd(16 downto 13) > "0100") then
			bcd(16 downto 13) := bcd(16 downto 13) + "0011";
		end if;
		if(i < 8 and bcd(20 downto 17) > "0100") then 
			bcd(20 downto 17) := bcd(20 downto 17) + "0011";
		end if;
		end loop;

--BCD output of sensor1
hundreds <= bcd(20 downto 17);
tens <= bcd(16 downto 13);
unit <= bcd(12 downto 9);

end process;

process(input2)
				variable j : integer:=0; 
				variable bcd2 : std_logic_vector(20 downto 0);
begin 
				bcd2 := (others => '0');
				bcd2(8 downto 0) := input2;
		for j in 0 to 8 loop 

			bcd2(19 downto 0) := bcd2(18 downto 0) & '0';


		if(j < 8 and bcd2(12 downto 9) > "0100") then
			bcd2(12 downto 9) := bcd2(12 downto 9) + "0011";
		end if;
		if(j < 8 and bcd2(16 downto 13) > "0100") then
			bcd2(16 downto 13) := bcd2(16 downto 13) + "0011";
		end if;
		if(j < 8 and bcd2(20 downto 17) > "0100") then 
			bcd2(20 downto 17) := bcd2(20 downto 17) + "0011";
		end if;
		end loop;

--BCD output of sensor2
hundreds_bcd<= bcd2(20 downto 17);
tens_bcd <= bcd2(16 downto 13);
unit_bcd <= bcd2(12 downto 9);

end process;

end Behavioral;


