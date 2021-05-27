program Lab10_Var9;

function getdigit25(c :Char) :LongInt;
var w :LongInt;
begin
    w := 0;
    case c of

        '0': w := 0;
        '1': w := 1;
        '2': w := 2;
        '3': w := 3;
        '4': w := 4;
        '5': w := 5;
        '6': w := 6;
        '7': w := 7;
        '8': w := 8;
        '9': w := 9;
        
        'A', 'a': w := 10;
        'B', 'b': w := 11;
        'C', 'c': w := 12;
        'D', 'd': w := 13;
        'E', 'e': w := 14;
        'F', 'f': w := 15;
        'G', 'g': w := 16;
        'H', 'h': w := 17;
        'I', 'i': w := 18;
        'J', 'j': w := 19;
        'K', 'k': w := 20;
        'L', 'l': w := 21;
        'M', 'm': w := 22;
        'N', 'n': w := 23;
        'O', 'o': w := 24;

    else { Error }
        w := -1;
    end;

    getdigit25 := w;
end;

function str25toint(var s :String) :LongInt;
var i, d :Integer; n :LongInt;
begin
    n := 0;
    for i := 1 to length(s) do
    begin
        d := getdigit25(s[i]);
        if d < 0 then { Error }
        begin
            str25toint := -1;
            exit;
        end;
        n := n*25 + d;
    end;
    str25toint := n;
end;

function validinput(var s :String) :Boolean;
var i, alphacount, len :Integer; d :LongInt; 
begin
    len := length(s);
    alphacount := 0;
    if (len < 4) or (len > 5) then
    begin
        validinput := false;
        exit;
    end;
    for i := 1 to len do
    begin
        d := getdigit25(s[i]);

        if d < 0 then { Error }
        begin
            validinput := false;
            exit;
        end;

        if d >= 10 then
        begin
            alphacount := alphacount + 1;
        end;

    end;
    validinput := (alphacount >= 2);
end;

var instr :String;
    n :LongInt;
begin
    write('Write your number (base of 25): ');
    readln(instr);
    
    if not validinput(instr) then
    begin
        writeln('Input is not valid!');
    end
    else
    begin
        n := str25toint(instr);
        
        writeln('Decimal: ', n);
    end;
end.
