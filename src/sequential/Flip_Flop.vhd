
------------- D Flip-Flop ---------------------

Entity FF_D is
	port (clk, D: in bit; 
	      Q, NQ: out bit);
end FF_D;

Architecture arch of FF_D is
	Begin
		Q <= D when (clk'Event) and (clk='1');
		NQ <= not D when (clk'Event) and (clk='1');
	End arch;

------------ JK Flip Flop ---------------

Entity FF_JK is
	port (clk, J, K: in bit; 
	      Q, NQ: out bit);
end FF_JK;

Architecture arch of FF_JK is
	signal aux:bit;
	Begin
		aux <= aux when (clk'Event) and (clk='1') a nd (J='0') and (K='0') else
		       '0' when (clk'Event) and (clk='1') and (J='0') and (K='1') else
		       '1' when (clk'Event) and (clk='1') and (J='1') and (K='0') else
		       not aux when (clk'Event) and (clk='1') and (J='1') and (K='1');
		
		Q <= aux;
		NQ <= not aux;
	End arch;

