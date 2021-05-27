program Lab8_Var9;

function fact(n :Integer) :LongInt;
var i :Integer; f :LongInt;
begin
    f := 1;
    for i := 1 to n do
    begin
        f := f*i;
    end;
    fact := f;
end;

function calc(a :Integer; var inarr :Array of Real; count :Integer) :Real;
var i :Integer; p :Real; { f :LongInt; }
begin
    p := 1;
    { f := 1; }
    for i := 0 to count-1 do
    begin
        p := p*(a + inarr[i])/fact(i+1);
        { 
        f := f*(i+1);
        p := p*(a + inarr[i])/f;
        }
    end;
    calc := p;
end;

var x, y, z :Real;
    b :Array of Real = ( 1.50, 0.09, 0.82, 1.13 );
    c :Array of Real = ( 0.85, 1.40, 1.12, 3.24 );
    d :Array of Real = ( 0.25, 0.21, 0.12, 0.39 );
begin
    x := calc(10, b, 4);
    y := calc(20, c, 4);
    z := calc(30, d, 4);

    writeln('X = ', x:0:6);
    writeln('Y = ', y:0:6);
    writeln('Z = ', z:0:6);
end.
