
---------- Adder_Half_Unity --------

ENTITY Adder_Half_Unity IS
	PORT(A,B:IN BIT;
	     S,C: OUT BIT
	);
END Adder_Half_Unity;

ARCHITECTURE arch OF Adder_Half_Unity IS
BEGIN
	S<=A XOR B;
	C<=A AND B;
END arch;

--------- Adder_Full_Unity -------------

ENTITY Adder_Full_Unity IS
	PORT(A,B,CI:IN BIT;
	S,CO:OUT BIT
	);
END Adder_Full_Unity;


ARCHITECTURE arch OF Adder_Full_Unity IS

	COMPONENT Adder_Half_Unity
		PORT(A,B:IN BIT;
			S,C:OUT BIT
		);
	END COMPONENT;
	SIGNAL S1,C1,C2:BIT;
BEGIN
	Adder_Half_Unity1: Adder_Half_Unity PORT MAP(A,B,S1,C1);
	Adder_Half_Unity2: Adder_Half_Unity PORT MAP(S1,CI,S,C2);
	CO <= C1 OR C2;
END arch;


----------- 3 bit Adder -------------------

ENTITY Adder_3bits IS
	PORT (
		X,Y:IN BIT_VECTOR(2 DOWNTO 0);
		S:OUT BIT_VECTOR(2 DOWNTO 0);
		FLAG:OUT BIT
	);
END Adder_3bits;

ARCHITECTURE ARCH OF Adder_3bits IS
	
	COMPONENT Adder_Half_Unity
		PORT(
			A,B:IN BIT;
	     	S,C: OUT BIT
		);
  	END COMPONENT;
	
	COMPONENT Adder_Full_Unity
		PORT(
			A,B,CI:IN BIT;
			S, CO: OUT BIT
		);
 	 END COMPONENT;
	
	SIGNAL CY:BIT_VECTOR(3 DOWNTO 0);
BEGIN

	Adder_Full_Unity0 :Adder_Half_Unity PORT MAP (X(0), Y(0), S(0), CY(0));
	Adder_Full_Unity1 :Adder_Full_Unity PORT MAP (X(1), Y(1), CY(0), S(1), CY(1));
	Adder_Full_Unity2 :Adder_Full_Unity PORT MAP (X(2), Y(2), CY(1), S(2), CY(2));

	FLAG <=CY(2);
END ARCH;



----------- Generic Adder -----------------

entity Adder is

generic(n: natural :=2);
port(	A:		in bit_vector(n-1 downto 0);
		B:		in bit_vector(n-1 downto 0);
		carry:	out bit;
		sum:	out bit_vector(n-1 downto 0)
);

end Adder;

architecture arch of Adder is

signal result: bit_vector(n downto 0);
 
begin					  
    result <= ('0' & A)+('0' & B);
    sum <= result(n-1 downto 0);
    carry <= result(n);
end arch;


