------------ 4 bit Counter --------------------

Entity Counter_4bit is
	port (clk, J, K: in bit; 
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
		Q <= aux_vec;
		
		jk_lsd: FF_JK port map (clk,'1','1',aux_vec(0));
		jk_1: FF_JK port map (clk,aux_vec(0),aux_vec(0),aux_vec(1));
		jk_2: FF_JK port map (clk,aux_1,aux_1,aux_vec(2));
		jk_msd: FF_JK port map (clk,aux_2,aux_2,aux_vec(3));

	End arch;




