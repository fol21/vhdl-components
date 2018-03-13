entity Detector_1011 IS
    PORT (X, CLK: IN BIT;
          Z: OUT BIT);
end Detector_1011; 

architecture arch OF Detector_1011 is
    TYPE ESTADO IS (RESET, TEM1, TEM10, TEM101, TEM1011);
    SIGNAL ATUAL: ESTADO := RESET;
    
  BEGIN
    
    output: PROCESS(ATUAL)
    BEGIN
        IF ATUAL = TEM1011 THEN Z <= '1';
        ELSE Z <= '0'; 
        END IF;   
    END PROCESS;
    
    transition: PROCESS(CLK)
    BEGIN
        IF (CLK'EVENT) AND (CLK = '1') THEN
          CASE ATUAL IS
            WHEN RESET   => IF X = '1' THEN ATUAL <= TEM1;
                            ELSE ATUAL <= RESET;
                            END IF;
            
            WHEN TEM1    => IF X = '0' THEN ATUAL <= TEM10;
                            ELSE ATUAL <= TEM1;
                            END IF;
                          
            WHEN TEM10   => IF X = '1' THEN ATUAL <= TEM101;
                            ELSE ATUAL <= RESET;
                            END IF;
                        
            WHEN TEM101  => IF X = '1' THEN ATUAL <= TEM1011;
                            ELSE ATUAL <= TEM10;
                            END IF;
            WHEN TEM1011 => IF X = '0' THEN ATUAL <= TEM10;
                            ELSE ATUAL <= TEM1;
                            END IF;   
         END CASE;
       END IF;
    END PROCESS;
END arch;