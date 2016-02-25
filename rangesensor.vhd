

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std;


entity rangesen is
    Port ( clk : in  STD_LOGIC;
	        echo: in  STD_LOGIC;
           trg : out  STD_LOGIC;
			  echo2: in  STD_LOGIC;
           trg2 : out  STD_LOGIC;
			  output : out std_logic_vector(8 downto 0);
			  output2 : out std_logic_vector(8 downto 0);
			  check1 : in std_logic_vector(7 downto 0) 
		  
			  
);
end rangesen;	
 

architecture Behavioral of rangesen is

         signal count: std_logic_vector(21 downto 0):= "0000000000000000000000";
		   signal count1: std_logic_vector(21 downto 0);
			
			signal count2: std_logic_vector(21 downto 0):= "0000000000000000000000";
		   signal count3: std_logic_vector(21 downto 0);
			
			signal input : STD_LOGIC_VECTOR(8 downto 0);			
			signal input2 : STD_LOGIC_VECTOR(8 downto 0);	

          signal int : integer;
			 signal int2 : integer;
			 signal int3:integer;
          signal int4:integer;

			
			
begin



process(clk)   
begin	


  if(clk'event and clk = '1') then   
  
 if (check1 = X"73") then  --check dbInsig contains ascii value of s or not
   if(count <= "000000000001001011000"  ) then  -- 600 clock cycles or 12 usecs
	
    trg <= '1';             
	   count <=count+"0000000000000000000001" ;
   else	
    trg <= '0';
	 count <=count+"0000000000000000000001" ;
	 
	 if (count ="1001100010010110100000") then --2500000 clock cycles or 50msecs 
	 count<="0000000000000000000000";	 
			
	end if;
	end if;
  end if;
 end if;
 end process;
 
process(clk)   
begin	


  if(clk'event and clk = '1') then  
  if (check1 = X"74")  then --check dbInsig contains ascii value of t or not

   if(count2 <= "000000000001001011000"  ) then
	
    trg2 <= '1';
	   count2 <=count2+"0000000000000000000001" ;
   else	
    trg2 <= '0';
	 count2 <=count2+"0000000000000000000001" ;
	 
	 if (count2 ="1001100010010110100000") then
	 count2<="0000000000000000000000";	
	 			
   end if;
	end if;
  end if;
 end if;
 end process;
 
 
	
process(clk, echo)   
begin

if clk'event and clk='1' then
      if echo = '1' then       
      int <= conv_integer(count1(21 downto 0)); -- convert the count value to integer
      int2 <= ((int)*3)/8192;         -- changing the number of clock cycles into centimeters
      input<= conv_std_logic_vector(int2,9);-- changing integer value into 9 bit binary value
      count1 <=count1+"0000000000000000000001";          
      else
		-- when object is detected 9 bit value of input signal is given to output signal
      output <=input;   
      count1 <="0000000000000000000000";    
     end if;
     end if;
end process;

process(clk, echo2)   
begin

if clk'event and clk='1' then
      if echo2 = '1' then    
      int3 <= conv_integer(count3(21 downto 0));
      int4 <= ((int3)*3)/8192;
      input2<= conv_std_logic_vector(int4,9);
      count3 <=count3+"0000000000000000000001";          
      else
      output2 <=input2;
      count3 <="0000000000000000000000";    
     end if;
     end if;
   
end process;





end Behavioral;