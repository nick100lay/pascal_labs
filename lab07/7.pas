program Lab7_Var9;

const count = 14;
var arr :Array[1..count] of Real;
    i, j, k :Integer; temp :Real;
begin
    writeln('Write your array with ', count, ' elements:');

    for i := 1 to count do
    begin
        write('arr[', i, '] := ');
        readln(arr[i]);
    end;

    for i := 2 to count do
    begin
        for j := 1 to i-1 do { Find x (x < x0) }
        begin
            if arr[i] > arr[j] then 
            begin
                temp := arr[i];

                for k := i downto j+1 do { Insert if found }
                begin
                    arr[k] := arr[k-1];
                end;

                arr[j] := temp; { Set value on j }
                break;
            end;
        end;
    end;
    
    writeln('Result:');
    for i := 1 to count do
    begin
        writeln(i, '. ', arr[i]:0:4);
    end;

end.

