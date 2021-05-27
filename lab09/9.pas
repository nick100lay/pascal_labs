program Lab9_Var9;

type    Vec4 = Array[1..4] of Real;
        Mat4 = Array[1..4, 1..4] of Real;

function func(
    var p, q :Vec4;
    i, j: Integer)
        :Real;
begin
    func := 
        (p[i]*p[i] + q[j]*q[j] + 2*p[j]*q[i])/(4*p[i]*q[j] + 1);
end;

procedure makemat(
    var mat :Mat4; 
    var p, q :Vec4);
var i, j :Integer;
begin
    for i := 1 to 4 do
    begin
        for j := 1 to 4 do
        begin
            mat[i, j] := func(p, q, i, j);
        end;
    end;
end;

procedure printmat(var mat :Mat4);
var i, j :Integer;
begin
    for i := 1 to 4 do
    begin
        write('[ ');
        for j := 1 to 4 do
        begin
            write(mat[i, j]:12:4, ' ');
        end;
        writeln(' ':5, ']');
    end;
end;

var x, y, z :Mat4;
var b :Vec4 = (  8.0,  4.2,  8.8, 5.5 ); { 1 }
var c :Vec4 = ( -1.0,  6.0, -1.8, 6.7 ); { 2 }
var d :Vec4 = (  0.7, -1.1,  5.1, 6.0 ); { 3 }
begin
    makemat(x, b, c);
    makemat(y, b, d);
    makemat(z, c, d);

    writeln('Matrix X:');
    printmat(x);
    writeln('Matrix Y:');
    printmat(y);
    writeln('Matrix Z:');
    printmat(z);
end.
