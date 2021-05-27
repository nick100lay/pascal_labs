program Lab11_Var9_makefile;

const filename='11_caesar.txt';
var outfile :TextFile;
begin
    assign(outfile, filename);
    rewrite(outfile);

    writeln(outfile, 'Hello world!');
    writeln(outfile, 'XYZ!');
    writeln(outfile, '$C$A$C:;we.32;100;..2');
    writeln(outfile, 'Ceasar');
    writeln(outfile, 'CeAsAr');
    writeln(outfile, 'cEaSaR');
    writeln(outfile, 'CEASAR');

    writeln(outfile, 'Lorem ipsum dolor sit amet,');
    writeln(outfile, 'consectetur adipiscing elit,');
    writeln(outfile, 'sed do eiusmod tempor incididunt');
    writeln(outfile, 'ut labore et dolore magna aliqua.');
    
    close(outfile)
    
end.
