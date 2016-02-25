
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-------------------------------------------------------------------------
--
--Title:	Main entity
--

-------------------------------------------------------------------------
entity uartl is
	Port ( 	TXD		: out std_logic := '1';
		 	RXD		: in std_logic 	:= '1';
		  	CLK		: in std_logic;
			LEDS	: out std_logic_vector(7 downto 0) ;
		  	RST		: in std_logic	:= '0';
			trig1 : out std_logic_vector(7 downto 0) ;
			tclk:inout std_logic;
			segment: out std_logic_vector(8 downto 0);
			segment1: out std_logic_vector(8 downto 0);
			char : out std_logic_vector(3 downto 0);
			cm:in std_logic_vector(8 downto 0);
	      cm2:in std_logic_vector(8 downto 0)
			);
end uartl;

architecture Behavioral of uartl is

-------------------------------------------------------------------------
-- Local Component, Type, and Signal declarations.								
-------------------------------------------------------------------------

-------------------------------------------------------------------------
--
--Title:	Component Declarations
--

-------------------------------------------------------------------------
component RS232RefComp
   Port (  	TXD 	: out	std_logic	:= '1';
		 	RXD 	: in	std_logic;					
  		 	CLK 	: in	std_logic;							
			DBIN 	: in	std_logic_vector (7 downto 0);
			DBOUT 	: out	std_logic_vector (7 downto 0);
			RDA		: inout	std_logic;							
			TBE		: inout	std_logic 	:= '1';				
			RD		: in	std_logic;							
			WR		: in	std_logic;							
			PE		: out	std_logic;							
			FE		: out	std_logic;							
			OE		: out	std_logic;											
			RST		: in	std_logic	:= '0';
			tclk:inout std_logic);				
end component;	
-------------------------------------------------------------------------
--
--Title:	Type Declarations
--

--
-------------------------------------------------------------------------
--different states for transmitting data
	type mainState is (
	stReceive,
		state1,
		state2,
		state3,
		state4
		  );

-------------------------------------------------------------------------
	signal dbInSig	:	std_logic_vector(7 downto 0);
	signal dbOutSig	:	std_logic_vector(7 downto 0);
	signal rdaSig	:	std_logic;
	signal tbeSig	:	std_logic;
	signal rdSig	:	std_logic;
	signal wrSig	:	std_logic;
	signal peSig	:	std_logic;
	signal feSig	:	std_logic;
	signal oeSig	:	std_logic;


	
	signal stCur	:	mainState := stReceive;
	signal stnext	:	mainState;

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------

begin



	UART: RS232RefComp port map (	TXD 	=> TXD,
									RXD 	=> RXD,
									CLK 	=> CLK,
									DBIN 	=> dbInSig,
									DBOUT	=> dbOutSig,
									RDA		=> rdaSig,
									TBE		=> tbeSig,	
									RD		=> rdSig,
									WR		=> wrSig,
									PE		=> peSig,
									FE		=> feSig,
									OE		=> oeSig,
									RST 	=> RST,
									tclk=>tclk);
-------------------------------------------------------------------------

--Title: Main State Machine controller 

-------------------------------------------------------------------------


process (tclk, RST)
--process for changing the states and runs with tclk (transmission clock)
		begin
		if (tclk = '1' and tclk'Event) then
			
				if RST = '1' then
					stCur <= stReceive;
				else
					stCur <= stnext;
					
				end if;
			end if;
		end process;




-------------------------------------------------------------------------
	process (tclk,stCur, rdaSig, dboutsig)

	begin
	if (tclk'Event and tclk = '1') then
	
		
			case stCur is
-------------------------------------------------------------------------

--Title: stReceive state 

-------------------------------------------------------------------------	

                --IDLE state
                when stReceive =>
                    rdSig <= '0';
                    wrSig <= '0';

                        if rdaSig = '1' then
								
                        if (dbOutSig = X"73") then  --check dbOutSig contains ascii value of s
			 
								trig1 <=dbOutSig;
                        dbInSig <= (15 downto 9=> '1')& cm2(8);--loading first byte of data from sensor1
								segment<= cm(8 downto 0);-- sending sensor1 data to seven segment
							
                        stnext <= state1;
                       elsif (dbOutSig = X"74") then ----check dbOutSig contains ascii value of t
          
						      trig1 <=dbOutSig;
								
                      dbInsig <=  (15 downto 9=> '1')& cm(8);--loading first byte of data from sensor2
							 segment1<= cm2(8 downto 0);-- sending sensor2 data to seven segment
							
							 
                        stnext <= state1;
                       else
                       stnext <= stReceive;
                        
                    end if;    
                    end if ;  
                    					  
-------------------------------------------------------------------------

--Title: stSend state 

-------------------------------------------------------------------------
--sending the data through uart
                when state1 =>
                    rdSig <= '0'; 
                    wrSig <= '1';
                    stnext <= state2 ;
                    
                    
                 when state2 => 
  -- back to idle state to load second byte of data
                  rdSig <= '0';
                  wrSig <= '0';
						if (dbOutSig = X"74") then  
						dbInsig <= cm2( 7 downto 0) ;--loading second byte of data from sensor1
						end if;
						if (dbOutSig = X"73") then
						dbInsig <= cm( 7 downto 0) ;--loading second byte of data from sensor2
						end if;
						stnext <= state3 ;
						
						when state3 => 
   --sending the data through uart
                  rdSig <= '0';
                  wrSig <= '1';
						stnext <= state4 ;
						
						when state4 => 
    -- stops sending the data through uart and making RDA port low   
                  rdSig <= '1';
                  wrSig <= '0';
						
						stnext <= stReceive ;
    
            end case;
          end if ;
       end process;
        
        

end Behavioral;



