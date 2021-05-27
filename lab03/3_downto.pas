program Lab3_Var9_Downto;

uses Math;

var k :Integer; s :Real;
begin
    s := 0;
    for k := 15 downto 1 do
    begin
        s := s + exp(0.1*k);
        writeln('Iter. ', k, ' s = ', s:0:6);
    end;
    writeln('Result: ', s:0:6);
end.
