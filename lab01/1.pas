
program Lab1_Var9;

uses Math;

var gamma, a, b, c :Real;
begin
    a := 1.98;
    c := 0.9 + a*a;
    b := 0.34/(a + c);
    gamma := a + power(sin(a*b*c)/(a + b + c), 0.48);
    writeln('Answer: ', gamma:0:6);
end.

