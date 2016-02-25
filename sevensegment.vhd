----------------------------------------------------------------------------------
-- Company: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity sevenseg is
 port(segclk: in std_logic;
      unit1:   in  STD_LOGIC_VECTOR(3 downto 0);
		tens1:   in  STD_LOGIC_VECTOR(3 downto 0);
		hundreds1:in  STD_LOGIC_VECTOR(3 downto 0);
		unit2:   in  STD_LOGIC_VECTOR(3 downto 0);
		tens2:   in  STD_LOGIC_VECTOR(3 downto 0);
		hundreds2:in  STD_LOGIC_VECTOR(3 downto 0);
		char1 : in std_logic_vector(3 downto 0);
		
		sseg: out STD_LOGIC_VECTOR(6 downto 0);
		anodes : out std_logic_vector(3 downto 0));

end sevenseg;

architecture Behavioral of sevenseg is

               signal r_anodes: std_logic_vector(3 downto 0);
					signal count : std_logic_vector(7 downto 0);
					signal count1 : std_logic_vector(32 downto 0);
					signal counter : std_logic_vector(1 downto 0);
					
--Initialising arrays to store s,t,d,A values
					type dbuff is array (0 to 3) of std_logic_vector(3 downto 0);
               signal x:dbuff;
					type dbuff1 is array (0 to 3) of std_logic_vector(3 downto 0);
               signal y:dbuff1;
					type dbuff2 is array (0 to 3) of std_logic_vector(3 downto 0);
               signal z:dbuff2;
					type dbuff3 is array (0 to 3) of std_logic_vector(3 downto 0);
               signal a:dbuff3;
					type dbuff4 is array (0 to 3) of std_logic_vector(3 downto 0);
               signal b:dbuff4;

					
					
            
					


begin
            --assigning sensor values to arrays
            x(0)<=unit1;
				x(1)<=tens1;
				x(2)<=hundreds1 ;
				x(3) <="0000" ;	
				y(0)<=unit2;
				y(1)<=tens2;
				y(2)<=hundreds2 ;
				y(3) <="0001" ;
				a(0)<="0000";
				a(1)<="0000";
				a(2)<="0000" ;
				a(3) <="0010" ;	
				b(0)<="0000";
				b(1)<="0000";
				b(2)<="0000" ;
				b(3) <="0011" ;

         process(segclk,x(0),x(1),x(2),x(3),y(0),y(1),y(2),y(3),a(0),a(1),a(2),a(3),b(0),b(1),b(2),b(3),count1)
			begin
			-- creating 2 seconds delay for displaying s,t,d,A values
			if rising_edge(segclk) then
			
			if count1 < "00000101111101011110000100000000" then      
            
            z(0)<=x(0);
				z(1)<=x(1);
				z(2)<=x(2) ;
				z(3) <=x(3) ;
            count1 <= count1 + 1;				
				elsif
			
				 count1 < "00001011111010111100001000000000" then
				z(0)<=y(0);
				z(1)<=y(1);
				z(2)<=y(2) ;
				z(3) <=y(3) ;
				 count1 <= count1 + 1;
				 elsif
				
				 count1 < "00010001111000011010001100000000" then
				z(0)<=a(0);
				z(1)<=a(1);
				z(2)<=a(2) ;
				z(3) <=a(3) ;
				 count1 <= count1 + 1;
				 elsif
			
				 count1 < "00010111110101111000010000000000" then
				z(0)<=b(0);
				z(1)<=b(1);
				z(2)<=b(2) ;
				z(3) <=b(3) ;
				 count1 <= count1 + 1;
				 
				else
				count1 <= (others=>'0');   
				end if;
				end if;
				
				end process;
				

-- lower the clock frequency to 10hz(200ms)
--This makes seven segment data visible to human eyes
begincountClock: process(segclk, counter,count)
    begin	 
       if rising_edge(segclk) then
			if count < "10000000" then       
            count <= count + 1;
			else				
				counter<=counter+1;				
				count<=(others=>'0');       
			end if;
		  end if;
    end process;
	 
	 
anodes <= r_anodes; 
	 
process(counter,unit1,tens1,hundreds1,char1)
begin        
-- incrementing the anodes with 200ms delay
		case counter(1 downto 0) is
            when "00" => r_anodes <="1110" ; 
            when "01" => r_anodes <= "1101"; 
				when "10" => r_anodes <= "1011"; 
				when "11" => r_anodes <= "0111"; 
            when others => r_anodes <= "1111"; 
		end case;
    -- displays the s,t,d,A values on seven segments
      case r_anodes is
		
				when "1110"  => 
			     
                  if z(0) = "0000"  then
                  sseg <= "1000000"; -- 0
                  elsif z(0) = "0001" then
                  sseg <= "1111001"; -- 1
				      elsif z(0) = "0010" then
                  sseg <= "0100100"; -- 2
				      elsif z(0) = "0011" then
                  sseg <= "0110000"; -- 3
				      elsif z(0) <= "0100" then
                  sseg <= "0011001"; -- 4
					   elsif z(0) = "0101" then
                  sseg <= "0010010"; -- 5
						elsif z(0) = "0110" then
                  sseg <= "0000010"; -- 6
						elsif z(0) = "0111" then
                  sseg <= "1111000"; -- 7
						elsif z(0) = "1000" then
                  sseg <= "0000000"; -- 8
						elsif z(0) = "1001" then
                  sseg <= "0010000"; -- 9
						elsif z(0) = "1010" then
                  sseg <= "0001000"; -- A
						elsif z(0) = "1011" then
                  sseg <= "0000011"; -- B
						elsif z(0) = "1100" then
                  sseg <= "1000110"; -- C
						elsif z(0) = "1101" then
                  sseg <= "0100001"; -- D
						elsif z(0) = "1110" then
                  sseg <= "0000110"; -- E
						else
						sseg <= "0000000";
						end if;
							
					
             when "1101"  =>             
                
				      if z(1) = "0000"  then
                  sseg <= "1000000"; -- 0
                  elsif z(1)  = "0001" then
                  sseg <= "1111001"; -- 1
				      elsif  z(1)  = "0010" then
                  sseg <= "0100100"; -- 2
				      elsif z(1)  = "0011" then
                  sseg <= "0110000"; -- 3
				      elsif  z(1)  = "0100" then
                  sseg <= "0011001"; -- 4
					   elsif  z(1)  = "0101" then
                  sseg <= "0010010"; --5
						elsif  z(1)  = "0110" then
                  sseg <= "0000010"; -- 6
						elsif  z(1)  = "0111" then
                  sseg <= "1111000"; -- 7
						elsif  z(1)  = "1000" then
                  sseg <= "0000000"; -- 8
						elsif  z(1)  = "1001" then
                  sseg <= "0010000"; -- 9
						elsif  z(1)  = "1010" then
                  sseg <= "0001000"; -- A
						elsif  z(1)  = "1011" then
                  sseg <= "0000011"; -- B
						elsif  z(1)   = "1100" then
                  sseg <= "1000110"; -- C
						elsif  z(1)   = "1101" then
                  sseg <= "0100001"; -- D
						elsif  z(1)   = "1110" then
                  sseg <= "0000110"; -- E
						else
						sseg <= "0000000";
						end if;
						
						
				when "1011"  =>             
               	 
				      if z(2) = "0000"  then
                  sseg <= "1000000"; -- 0
                  elsif z(2)  = "0001" then
                  sseg <= "1111001"; -- 1
				      elsif z(2)  = "0010" then
                  sseg <= "0100100"; -- 2
				      elsif z(2)  = "0011" then
                  sseg <= "0110000"; -- 3
				      elsif z(2)  = "0100" then
                  sseg <= "0011001"; -- 4
					   elsif z(2)  = "0101" then
                  sseg <= "0010010"; --5
						elsif z(2)  = "0110" then
                  sseg <= "0000010"; -- 6
						elsif z(2)  = "0111" then
                  sseg <= "1111000"; -- 7
						elsif z(2)  = "1000" then
                  sseg <= "0000000"; -- 8
						elsif z(2)  = "1001" then
                  sseg <= "0010000"; -- 9
						elsif z(2)  = "1010" then
                  sseg <= "0001000"; -- A
						elsif z(2)  = "1011" then
                  sseg <= "0000011"; -- B
						elsif z(2)  = "1100" then
                  sseg <= "1000110"; -- C
						elsif z(2)  = "1101" then
                  sseg <= "0100001"; -- D
						elsif z(2)  = "1110" then
                  sseg <= "0000110"; -- E
						else
						sseg <= "0000000";
						end if;
					
					
				when "0111" => 
			         if (z(3) = "0000")  then
                  sseg <= "0010010"; --s
                  elsif (z(3) = "0001") then
                  sseg <= "0000111"; -- t
						elsif (z(3) = "0010") then
                  sseg <= "0100001"; -- d
						elsif (z(3) = "0011") then
                  sseg <= "0001000"; -- A
						else 
                  sseg <= "1111111"; -- nothing
						end if;
						
						
				when others => 
					   sseg <= "1111111"; 

			end case;
end process;

end Behavioral;

