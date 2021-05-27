program Lab2_Var9;

const x0 = 2.5; y0 = 4.0; a = 2.5; b = 4.0;
var x, y, vx, vy :Real;
begin
    writeln('Write a point:');
    readln(x, y);
    vx := x - x0;
    vy := y - y0;
    if (vx >= 0.0) and (vy >= -vx) and (vx*vx/(a*a) + vy*vy/(b*b) <= 1.0) 
    then
    begin
        writeln('Inside');
    end
    else
        writeln('Outside');
end.
