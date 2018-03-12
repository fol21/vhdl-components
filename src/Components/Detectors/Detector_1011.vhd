entity Detector_1011 is
  port (
    x, clock : in bit;
    z : out bit
  ) ;
end Detector_1011 ;

architecture arch of Detector_1011 is
type state is (reset, tem1, tem10, tem101);
signal atual : state := reset;

begin
  Transition : process( clock )
  begin
    if (clock'Event) and (clock = '1') then
      case( atual ) is
      
        when reset =>
          Z <= '0'; 
          if x = '1'  then atual <= tem1;
          else atual <= reset;
          end if ;
        
        when tem1 => 
          Z <= '0';
          if x = '0'  then atual <= tem10;
          else atual <= tem1;
          end if ;
        
        when tem10 =>
          Z <= '0'; 
          if x = '1'  then atual <= tem101;
          else atual <= reset;
          end if ;
        
        when tem101 => 
          Z <= '0';
          if x = '1'  then Z <= '1'; atual <= tem1;
          else Z <= '0'; atual <= tem10;
          end if ;
       
      end case ;
    end if;
  end process ; -- Transition
end architecture ; -- arch

----------- Alternante ---------------

entity Detector_1011 is
  port (
    x, clock : in bit;
    z : out bit
  ) ;
end Detector_1011 ;

architecture arch of Detector_1011 is
type state is (reset, tem1, tem10, tem101, tem1011);
signal atual : state := reset;

begin
  Transition : process( clock )
  begin
    if (clock'Event) and (clock = '1') then
      case( atual ) is
      
        when reset =>
          Z <= '0'; 
          if x = '1'  then atual <= tem1;
          else atual <= reset;
          end if ;
        
        when tem1 => 
          Z <= '0';
          if x = '0'  then atual <= tem10;
          else atual <= tem1;
          end if ;
        
        when tem10 =>
          Z <= '0'; 
          if x = '1'  then atual <= tem101;
          else atual <= reset;
          end if ;
        
        when tem101 => 
          Z <= '0';
          if x = '1'  then atual <= tem1011;
          else atual <= tem10;
          end if ;
        when tem1011 => 
          Z <= '1';
          if x = '1'  then atual <= tem1;
          else Z <= '0'; atual <= tem10;
          end if ;
      end case ;
    end if;
  end process ; -- Transition
end architecture ; -- arch


