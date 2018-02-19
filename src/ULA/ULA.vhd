-------------- Decoder --------------------

entity ULA_Decoder is
  port (
	F0,F1: in bit;
	S0,S1,S2,S3: in bit
  );
end ULA_Decoder;

architecture arch of ULA_Decoder is

begin
	S0 <= (not F0) and (not F1);
	S1 <= (not F0) and (F1);
	S2 <= (F0) and (not F1);
	S3 <= (F0) and (F1);

end arch ; -- arch

----------- Logic Unity ----------------------

entity ULA_Logic_Unity is
  port (
    X, Y, DIN1, DIN2, DIN3: in bit;
    S1, S2, S3 in bit
  ) ;
end ULA_Logic_Unity;

architecture arch of ULA_Logic_Unity is
	
	signal aux1, aux2 aux3 : bit;
	
	begin
		aux1 <= X and Y;
		aux2 <= X or Y;
		aux3 <= not Y;
		
		S1 <= aux1 and DIN1
		S2 <= aux2 and DIN2
		S3 <= aux3 and DIN3 
	
end arch ; -- arch


---------- ULA_Adder_Half_Unity --------

ENTITY ULA_Adder_Half_Unity IS
	PORT(A,B, DIN4:IN BIT;
	     S,C: OUT BIT
	);
END ULA_Adder_Half_Unity;

ARCHITECTURE arch OF ULA_Adder_Half_Unity IS

BEGIN
	S<=A XOR B;
	C<=A AND B AND DIN4;
END arch;

--------- Adder_Full_Unity -------------

ENTITY ULA_Adder_Full_Unity IS
	PORT(A,B, DIN4, CI:IN BIT;
	S,CO:OUT BIT
	);
END ULA_Adder_Full_Unity;


ARCHITECTURE arch OF ULA_Adder_Full_Unity IS

	COMPONENT ULA_Adder_Half_Unity
		PORT(A,B, DIN4:IN BIT;
			S,C:OUT BIT
		);
	END COMPONENT;
	SIGNAL S1,S2C1,C2:BIT;
BEGIN
	ULA_Adder_Half_Unity1: ULA_Adder_Half_Unity PORT MAP(A,B, DIN4,S1,C1);
	ULA_Adder_Half_Unity2: ULA_Adder_Half_Unity PORT MAP(S1,CI,DIN4,S2,C2);
	CO <= C1 OR C2;
	S <= S2 AND DIN4;
END arch;


------------- ULA unity ----------------------

entity ULA_Unity is
  port (
	X,Y,F0,F1,CI : in bit;
	CO,R : out bit
  );
end ULA_Unity;

architecture arch of ULA_Unity is


	component ULA_Decoder
		port (
				F0,F1: in bit;
				S0,S1,S2,S3: in bit
			);
	end component;

	component ULA_Logic_Unity
		port (
				X, Y, DIN1, DIN2, DIN3: in bit;
				S1, S2, S3 in bit
			) ;
	end component;

	component ULA_Full_Adder_Unity
		PORT(A,B, DIN4, CI : IN BIT;
			 S,CO : OUT BIT
			);
	end component;
	
	signal aux1,aux2,aux3,aux4 : bit;
	signal dout1,dout2,dout3,dout4 : bit;

	begin

		decoder : ULA_Decoder port map(F0,F1,dout1,dout2,dout3,dout4);
		logic : ULA_Logic_Unity port map(X,Y,dout1,dout2,dout3,aux1,aux2,aux3);
		adder : ULA_Full_Adder_Unity port map(X,Y,dout4,CI,aux4,CO);
		R <= aux1 or aux2 or aux3 or aux4;

	end arch ; -- arch

----------- Generic ULA ------------------

entity ULA is
port (	num_A: 	in bit_vector(15 downto 0);
		num_B: 	in bit_vector(15 downto 0);
		jpsign:	in bit;
		ULAs:	in bit_vector(1 downto 0);
		ULAz:	out bit;
		ULAout:	out bit_vector(15 downto 0)
);
end ULA;

architecture behv of ULA is

signal ULA_tmp: bit_vector(15 downto 0);

begin

	process(num_A, num_B, ULAs)
	begin			
		case ULAs is
		  when "00" => ULA_tmp <= num_A;
		  when "01" => ULA_tmp <= num_B;
		  when "10" => ULA_tmp <= num_A + num_B;
		  when "11" => ULA_tmp <= num_A - num_B;
		  when others =>
	    end case; 					  
	end process;
	
	process(jpsign, ULA_tmp)
	begin
		if (jpsign = '1' and ULA_tmp = ZERO) then
			ULAz <= '1';
		else
			ULAz <= '0';
		end if;
	end process;					
	
	ULAout <= ULA_tmp;
	
end behv;



