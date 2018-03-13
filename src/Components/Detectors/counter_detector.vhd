entity Conter_Detector_1011 is
  port (
    x, clock : in bit;
    outp : out bit_vector(3 downto 0)
  ) ;
end Conter_Detector_1011 ;

architecture arch of Conter_Detector_1011 is

component Counter_4bit is
	port (clk : in bit; 
	      Q, NQ: out Bit_vector(3 downto 0)
	      );
end component;

component Detector_1011 is
  port (
    X, CLK : in bit;
    Z : out bit
  ) ;
end component ;

signal aux: bit;
signal o, no : bit_vector(3 downto 0);

begin
 
   dctr: Detector_1011 port map (x,clock,aux);
   ctr: Counter_4bit port map (aux, o, no); 	 	
   outp <= o; 

end architecture ; -- arch