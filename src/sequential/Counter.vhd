Entity FF_JK is
	port (clk, J, K: in bit; 
	      Q, NQ: out bit);
end FF_JK;

Architecture arch of FF_JK is
	signal aux:bit;
	Begin
		aux <= aux when (clk'Event) and (clk='1') and (J='0') and (K='0') else
		       '0' when (clk'Event) and (clk='1') and (J='0') and (K='1') else
		       '1' when (clk'Event) and (clk='1') and (J='1') and (K='0') else
		       not aux when (clk'Event) and (clk='1') and (J='1') and (K='1');
		
		Q <= aux;
		NQ <= not aux;
	End arch;


------------ 4 bit Counter --------------------

Entity Counter_4bit is
	port (clk : in bit; 
	      Q, NQ: out Bit_vector(3 downto 0)
	      );
end Counter_4bit;

Architecture arch of Counter_4bit is
	Component FF_JK
		port (clk, J, K: in bit; 
	      	      Q, NQ: out bit);
	End Component;
	
	signal aux_1,aux_2:bit;
	signal aux_vec:bit_vector(3 downto 0); 
	BEGIN
		aux_1 <= aux_vec(0) and aux_vec(1);
		aux_2 <= aux_1 and aux_vec(2);

		jk_lsd: FF_JK port map (clk,'1','1',aux_vec(0));
		jk_1: FF_JK port map (clk,aux_vec(0),aux_vec(0),aux_vec(1));
		jk_2: FF_JK port map (clk,aux_1,aux_1,aux_vec(2));
		jk_msd: FF_JK port map (clk,aux_2,aux_2,aux_vec(3));
		
		Q <= aux_vec;		
	
	End arch;




