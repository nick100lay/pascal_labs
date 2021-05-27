program Lab12_Var9;

type Node = record
    value :Integer;
    right :^Node;
end;

type List = record
    start :^Node;
    marker :^Node;
end;

type ListFile = File of Integer;

procedure initlist(var l :List);
begin
    l.start := nil;
    l.marker := nil;
end;

procedure moveright(var l :List);
begin
    if l.marker <> nil then
    begin
        l.marker := l.marker^.right;
    end;
end;

procedure appendright(var l :List; value :Integer);
var newn, prevn :^Node; 
begin

    new(newn);
    newn^.value := value;
    writeln('DEBUG append: New element created. Value: ', value);
    
    if l.start = nil then { List is empty }
    begin
        l.start := newn;
        l.start^.right := newn;
        l.marker := newn;
        writeln('DEBUG append: List was empty');
    end
    else
    begin
        prevn := l.marker^.right;
        l.marker^.right := newn;    
        newn^.right := prevn;
    end;
end;

procedure removeright(var l :List);
var right :^Node;
begin
    if l.start = nil then { List is empty }
    begin
        exit;
    end;
    
    right := l.marker^.right;
    if right = l.marker then { List is empty now }
    begin
        initlist(l);
        writeln('DEBUG remove: List will be empty now');
    end
    else
        l.marker^.right := right^.right;

    if right = l.start then { Change start position }
    begin
        l.start := l.marker;
        writeln('DEBUG remove: Change the start');
    end;

    dispose(right);
    writeln('DEBUG remove: Element disposed');
end;

procedure removemarker(var l :List);
var cur :^Node;
begin
    cur := l.start;
    if cur = nil then { List is empty. }
    begin
        exit;
    end;

    while cur^.right <> l.marker do
    begin
        cur := cur^.right;
    end;
    l.marker := cur;
    removeright(l);
end;

procedure destroylist(var l :List);
begin
    while l.start <> nil do
    begin
        removeright(l);
    end;
end;

procedure printlist(var l :List);
var cur :^Node; 
begin
    cur := l.start;
    if cur = nil then
    begin
        writeln('<EMPTY>');
        exit;
    end;
    write('[ ');
    repeat
    begin
        if cur = l.marker then
        begin
            write('*');
        end;
        write(cur^.value, ', ');
        cur := cur^.right;
    end;
    until cur = l.start; 
    writeln(']');
end;

procedure readlist(var l :List; var infile :ListFile);
var value :Integer;
begin
    while not eof(infile) do
    begin
        read(infile, value);
        writeln('DEBUG read: Read value ', value);
        appendright(l, value);
        l.marker := l.marker^.right;
    end;
end;

procedure writelist(var l :List; var outfile :ListFile);
var cur :^Node;
begin
    cur := l.start;
    if cur = nil then { List is empty }
    begin
        exit;
    end;

    repeat
    begin
        write(outfile, cur^.value);
        writeln('DEBUG write: Write value ', cur^.value);
        cur := cur^.right;
    end;
    until cur = l.start;
end;

procedure printmenu();
begin
    writeln('1) Move right.');
    writeln('2) Append right.');
    writeln('3) Remove the marker.');
    writeln('4) Write to file.');
    writeln('5) Read from file.');
    writeln('0) Create a new list.');
    writeln('^C to exit.');
end;

function openfile(var filename :String; var fd :ListFile; toread :Boolean) :Boolean;
begin
    assign(fd, filename);
    if toread then
    begin
        reset(fd);
    end
    else
        rewrite(fd);
    openfile := (ioresult() = 0);
end;

var choice :Char; 
    l :List;
    value :Integer;
    filename :String;
    fd :ListFile;
begin

    initlist(l);

    while true do
    begin
        writeln('Menu:');
        printmenu();
        writeln('List:');
        printlist(l);
        write('Choice: ');
        readln(choice);
        case choice of
            '1': moveright(l);

            '2': begin
                write('Write your value: ');
                readln(value);
                appendright(l, value);
            end;

            '3': removemarker(l);

            '4': begin
                write('Write your file: ');
                readln(filename);
                if not openfile(filename, fd, false) then
                begin
                    writeln('Cant open file!');
                end
                else
                begin
                    writelist(l, fd);
                    close(fd);
                end;
            end;

            '5': begin
                write('Write your file to read: ');
                readln(filename);
                if not openfile(filename, fd, true) then
                begin
                    writeln('Cant open file!');
                end
                else
                begin
                    destroylist(l);
                    readlist(l, fd);
                    l.marker := l.start;
                    close(fd);
                end;
            end;

            '0': destroylist(l);
        end;
    end;
    
end.

