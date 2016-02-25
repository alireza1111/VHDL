
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_module is
		port(clk_main : in  STD_LOGIC;
	        echo: in  STD_LOGIC;
			   echo2: in  STD_LOGIC;
           trg : out  STD_LOGIC;
			  trg2 : out  STD_LOGIC;
			  sseg: out std_logic_vector(6 downto 0);
			  anodes: out std_logic_vector(3 downto 0);
			  TXD		: out std_logic := '1';
		 	  RXD		: in std_logic 	:= '1';
			  RST		: in std_logic	:= '0';
			  LEDS	: out std_logic_vector(7 downto 0) 
			  
    );
end top_module;

architecture Behavioral of top_module is

component rangesen
port( clk : in  STD_LOGIC;
	        echo: in  STD_LOGIC;
           trg : out  STD_LOGIC;
			  echo2: in  STD_LOGIC;
           trg2 : out  STD_LOGIC;
			  output : out std_logic_vector(8 downto 0);
			  output2 : out std_logic_vector(8 downto 0);
			  check1 : in  std_logic_vector(7 downto 0) 
		     
		);
end component;
         
component bin2bcd
port(  input1 : in STD_LOGIC_VECTOR(8 downto 0);
       input2 : in STD_LOGIC_VECTOR(8 downto 0);
		 hundreds : out  STD_LOGIC_VECTOR(3 downto 0);
       tens : out  STD_LOGIC_VECTOR(3 downto 0);
       unit : out  STD_LOGIC_VECTOR(3 downto 0);
		 hundreds_bcd : out  STD_LOGIC_VECTOR(3 downto 0);
       tens_bcd : out  STD_LOGIC_VECTOR(3 downto 0);
       unit_bcd : out  STD_LOGIC_VECTOR(3 downto 0)
		 );
end component;	 

component sevenseg
port( segclk :   in std_logic;
      unit1:   in  STD_LOGIC_VECTOR(3 downto 0);
		tens1:   in  STD_LOGIC_VECTOR(3 downto 0);
		hundreds1:in  STD_LOGIC_VECTOR(3 downto 0);
		unit2:   in  STD_LOGIC_VECTOR(3 downto 0);
		tens2:   in  STD_LOGIC_VECTOR(3 downto 0);
		hundreds2:in  STD_LOGIC_VECTOR(3 downto 0);
		sseg: out STD_LOGIC_VECTOR(6 downto 0);
      anodes: out std_logic_vector( 3 downto 0)
		
		 );
end component;	

component uartl
port(    TXD		: out std_logic := '1';
		 	RXD		: in std_logic 	:= '1';
		  	CLK		: in std_logic;
			LEDS	: out std_logic_vector(7 downto 0);
		  	RST		: in std_logic	:= '0';
			tclk:inout std_logic;
			trig1 : out std_logic_vector(7 downto 0) ;
			segment :out std_logic_vector(8 downto 0);
			segment1 :out std_logic_vector(8 downto 0);
			cm:     in std_logic_vector(8 downto 0);
			cm2:     in std_logic_vector(8 downto 0)
		);
end component;
         

		signal h :   STD_LOGIC_VECTOR(3 downto 0);
      signal t :   STD_LOGIC_VECTOR(3 downto 0);
      signal u :   STD_LOGIC_VECTOR(3 downto 0);
		
		signal h1 :   STD_LOGIC_VECTOR(3 downto 0);
      signal t1 :   STD_LOGIC_VECTOR(3 downto 0);
      signal u1:   STD_LOGIC_VECTOR(3 downto 0);
	
		
		signal trigger1:std_logic_vector(7 downto 0) ;
    
		

		signal dist1 : STD_LOGIC_VECTOR(8 downto 0);
		signal dist2 : STD_LOGIC_VECTOR(8 downto 0);
		signal segment_r1: std_logic_vector(8 downto 0); 
		signal segment_r2: std_logic_vector(8 downto 0); 
		

begin

 rangesensor: rangesen port map (  clk => clk_main,
											  echo => echo,
											  echo2 => echo2,
											  trg => trg,
											  trg2 => trg2,
											  check1=>trigger1,
											  output => dist1,
											  output2 => dist2
											  );
											  
											  
 binarytobcd: bin2bcd  port map (  input1   => segment_r1,
                                   input2   => segment_r2,
                                   hundreds => h,
                                   tens     => t,
                                   unit     => u,
											  hundreds_bcd =>h1,
											  tens_bcd    =>  t1,
											  unit_bcd    =>  u1
											  );
											  
 sevensegment: sevenseg port map ( segclk   => clk_main,
											  hundreds1 => h,
                                   tens1     => t,
                                   unit1     => u,
											  hundreds2 => h1,
                                   tens2     => t1,
                                   unit2     => u1,
											  sseg     => sseg,
											  anodes   => anodes
											   );	

 DataCntrl: uartl port map        ( TXD		 =>  TXD,
		 	                          RXD		 =>  RXD,
		  	                          CLK		 =>  clk_main,
			                          segment => segment_r1,
											  segment1 => segment_r2,
		  	                          RST		 =>  RST,
											  trig1   =>  trigger1,
											  cm      =>  dist1,
											  cm2      =>  dist2,
											  LEDS    =>  LEDS
											  
			                               
											  );									  
													  


end Behavioral;

