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




----------- Generic Counter ----------------


entity Counter is

generic(n: natural :=2);
port(	
    clk:	in bit;
	clear:	in bit;
	count:	in bit;
	Q:	out bit_vector(n-1 downto 0)
);
end Counter;
architecture arch of Counter is		 	  
	
    signal aux: bit_vector(n-1 downto 0);

begin

    process(clk, count, clear)
        begin
        if clear = '1' then
            aux <= aux - aux;
        elsif (clk='1' and clk'event) then
            if count = '1' then
            aux <= aux + 1;
            end if;
        end if;
    end process;	

    Q <= aux;

end arch;