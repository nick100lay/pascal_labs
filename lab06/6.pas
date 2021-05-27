program Lab6_Var9;

uses Math;

const eps = 1e-3;
var i, j :Integer; res, ds, s :Real;
begin
    res := 0;
    for i := 1 to 12 do
    begin
        j := 1;
        ds := eps;
        s := 0;
        writeln('Iter. ', i, ' result = ', res:0:6);
        while abs(ds) > eps do
        begin
            ds := tan(1/(i*j))/(j*j*j);
            s := s + ds;
            writeln(' |Iter. ', j, ' ds = ', ds:0:6, ' s = ', s:0:6);
            j := j + 1;
        end;
        res := res + i*i*s;
    end;
    writeln('Result: ', res:0:6);
end.
