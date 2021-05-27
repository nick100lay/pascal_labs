program Lab3_Var9;

uses Math;

var k :Integer; s :Real;
begin
    s := 0;
    for k := 1 to 15 do
    begin
        s := s + exp(0.1*k);
        writeln('Iter. ', k, ' s = ', s:0:6);
    end;
    writeln('Result: ', s:0:6);
end.
