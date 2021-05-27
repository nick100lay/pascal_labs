program Lab5_Var9;

uses Math;

{ 
    F(x) = arcsin(exp(-x));
    G(x) = arccos(power(10, -x);
}

var i :Integer; x, f, g : Real;
begin
    { Header }
    writeln('[=============================]');
    writeln('[  x  |   F(x)    |   G(x)    ]');
    writeln('[=============================]');
    { Rows }
    for i := 0 to 15 do begin
        x := 2.0 + i*0.2;
        f := arcsin(exp(-x));
        g := arccos(power(10, -x));
        { x, F, G columns }
        writeln('[', x:4:1, ' |', f:10:7, ' |', g:10:7, ' ]');
    end;
    { Bottom }
    writeln('[=============================]');
end.


