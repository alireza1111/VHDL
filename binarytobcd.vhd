----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:52:07 04/18/2013 
-- Design Name: 
-- Module Name:    rangesensor - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity rangesen is
    Port ( clk : in  STD_LOGIC;
	        echo: in  STD_LOGIC;
           trg : out  STD_LOGIC;
			  output : out std_logic_vector(8 downto 0)
);
end rangesen;	
 

architecture Behavioral of rangesen is

         signal count: std_logic_vector(21 downto 0):= "0000000000000000000000";
		   signal count1: std_logic_vector(23 downto 0);
			
			
			signal range_cm: std_logic_vector(25 downto 0);
			signal input : STD_LOGIC_VECTOR(8 downto 0);			
			
			
begin

process(clk)   
begin	
  if(clk'event and clk = '1') then    
   if(count <= "000000000001001011000"  ) then
    trg <= '1';
	   count <=count+"0000000000000000000001" ;
   else	
    trg <= '0';
	 count <=count+"0000000000000000000001" ;
	 
	 if (count ="1001100010010110100000") then
			count<="0000000000000000000000";	 
	 end if;
	end if;
  end if;
end process;
	
process(clk, echo)   
begin
    if clk'event and clk='1' then
	  if echo = '1' then	   
		   count1 <=count1+"000000000000000000001";                  			
			else	
			count1 <="000000000000000000000000";
	  end if;
	 end if;		
end process;

process(echo, clk)
begin
  if clk'event and clk ='1' then
	if echo = '1' then    
	 range_cm <= count1(23 downto 0)* "11";   --measuring distance
	 input <=range_cm(21 downto 13);	 
	 else
    output <=input;
	end if;
  end if;
end process; 

end Behavioral;