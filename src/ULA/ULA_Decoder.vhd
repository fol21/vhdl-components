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
