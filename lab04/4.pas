program Lab4_Var9;

const x = 7.55; eps = 1e-4;
var i :Integer; s, d :Real; fact :LongInt;
begin
    d := eps;
    fact := 1;
    i := 0;
    s := 0.0;
    while abs(d) >= eps do
    begin
        i := i + 1;
        fact := fact*i;
        d := exp(i/x)/(fact - 5);
        s := s + d;
        writeln('Iter. ', i, ' s = ', s:0:6);
    end;
    writeln('Result: ', s:0:6);
end.
