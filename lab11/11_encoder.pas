program Lab11_Var9_encoder;

type ByteStr = File of Byte;

procedure caesar(
    var buff :Array of Byte; 
    var size :Integer;
    var infile :ByteStr;
    key :Integer);
var b, p, c :Byte; i :Integer;
begin
    i := 0;
    while not eof(infile) do
    begin
        read(infile, b);
        case b of
            65..90:  p := 65; { Upper case }
            97..122: p := 97; { Lower case }
        else
            p := 0;           { Not an alphabet }  
        end;

        if p > 0 then
        begin
            c := b - p;
            if key < 0 then
            begin
                b := p + abs(((25 - c - key) mod 26) - 25);
            end
            else
                b := p + ((c + key) mod 26);
        end; 

        buff[i] := b;
        i := i + 1;
    end;

    size := i;

end;

procedure writebuff(
    var buff :Array of Byte; 
    size :Integer;
    var outfile :ByteStr);
var i :Integer;
begin
    for i := 0 to size-1 do
    begin
        write(outfile, buff[i]);
    end;
end;

const   key = 3;
        filename = '11_caesar.txt';
var buff :Array[0..1000] of Byte;
    size :Integer;
    infile, outfile :File of Byte;
begin

    assign(infile, filename);
    assign(outfile, filename);
    
    reset(infile);
    caesar(buff, size, infile, key);
    close(infile);

    rewrite(outfile);
    writebuff(buff, size, outfile);
    close(outfile);

end.

