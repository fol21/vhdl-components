------------- ULA unity -------------------

----------- Generic ULA Unity ------------------

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



