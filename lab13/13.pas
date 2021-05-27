program Lab13_Var9;


uses
    Crt, Cthreads, Sysutils, Math, Ptcgraph;
    
type GraphFunc = function(x :Real) :Real;
type GraphInfo = record
    w0, w1, h0, h1 :SmallInt; { Graph rectangle }
    ymin, ymax :Real; 
    fromx, tox :Real;
    sx, sy :Real; { Scale }
end;

procedure procgraphinfo(
    var info :GraphInfo; 
    w0, w1, h0, h1 :Integer; 
    ymin, ymax :Real;
    fromx, tox :Real);
begin
    info.w0 := w0;
    info.w1 := w1;
    info.h0 := h0;
    info.h1 := h1;
    info.ymin := ymin;
    info.ymax := ymax;
    info.fromx := fromx;
    info.tox := tox;
    info.sx := abs(w1 - w0)/abs(tox - fromx);
    info.sy := abs(h1 - h0)/abs(ymax - ymin);
end;

procedure detminmax(
    func :GraphFunc;
    var ymin :Real; var ymax :Real;
    fromx, tox, dx :Real);
var x, y :Real;
begin
    x := fromx;
    ymin := INFINITY;
    ymax := -INFINITY;
    while x < tox do
    begin
        y := func(x);
        if y > ymax then
        begin
            ymax := y;
        end;
        if y < ymin then
        begin
            ymin := y;
        end;
        x := x + dx;
    end;
end;

procedure drawgraph(func :GraphFunc; var info :GraphInfo; dx :Real);
var x, y :Real; px0, py0, px1, py1 :Integer; first :Boolean;
begin
    x := info.fromx;
    first := true;
    px0 := 0;
    py0 := 0;
    while x < info.tox do
    begin
        y := func(x);
        px1 := info.w0 + round(abs(x - info.fromx)*info.sx);
        py1 := info.h0 - round(abs(y - info.ymin)*info.sy);
        if first then 
        begin
            first := false
        end
        else
            line(px0, py0, px1, py1);
        px0 := px1;
        py0 := py1;
        x := x + dx;
    end;
end;

procedure drawdiv(
    var info :GraphInfo; 
    ishoriz :Boolean;
    startx, starty :Integer;
    divsize, divcount, divprec :Integer);
var ddiv, divpos :Integer;
    ddivval, divval, divpow :Extended;
    len, i :Integer; 
begin
    divpow := power(10, divprec);
    if ishoriz then
    begin
        len := abs(info.w1 - info.w0);
        divval := round(info.fromx*divpow);
        ddivval := round(abs(info.tox - info.fromx)/divcount*divpow);
    end
    else
    begin
        len := abs(info.h0 - info.h1);
        divval := round(info.ymin*divpow);
        ddivval := round(abs(info.ymax - info.ymin)/divcount*divpow);
    end;
    ddiv := len div divcount;

    for i := 0 to divcount do
    begin
        divpos := i*ddiv;
        if ishoriz then
        begin
            divpos := info.w0 + divpos;
            line(divpos, starty + divsize, divpos, starty - divsize);
            outtextxy(divpos, starty + round(divsize*1.5), floattostrf(divval/divpow, FFFIXED, divprec, divprec));
        end
        else
        begin
            divpos := info.h0 - divpos;
            line(startx + divsize, divpos, startx - divsize, divpos);
            outtextxy(startx - round(divsize*1.5), divpos, floattostrf(divval/divpow, FFFIXED, divprec, divprec));
        end;
        divval := divval + ddivval;
    end;

end;

procedure drawframe(var info :GraphInfo; 
    mleft, mright, mtop, mbottom :Integer; 
    arrowsize :Integer;
    divsize, divx, divy, divprec :Integer;
    fontsize :Integer);
var startx, starty, topend, rightend :Integer;
begin
    startx := info.w0 - mleft;
    rightend := info.w1 + mright;
    starty := info.h0 + mbottom; 
    topend := info.h1 - mtop;

    settextstyle(DEFAULTFONT, HORIZDIR, fontsize);

    { X axis }
    line(startx, starty, rightend, starty);
    settextjustify(LEFTTEXT, TOPTEXT);
    outtextxy(rightend + 5, starty, 'X');
    { Y axis }
    line(startx, starty, startx, topend);
    settextjustify(RIGHTTEXT, BOTTOMTEXT);
    outtextxy(startx, topend - 5, 'Y');

    { Arrow }
    line(startx, topend, startx - arrowsize, topend + arrowsize);
    line(startx, topend, startx + arrowsize, topend + arrowsize);
    line(rightend, starty, rightend - arrowsize, starty + arrowsize);
    line(rightend, starty, rightend - arrowsize, starty - arrowsize);
    {=}

    { Division }

    settextjustify(RIGHTTEXT, TOPTEXT);

    drawdiv(info, true, startx, starty, divsize, divx, divprec);
    drawdiv(info, false, startx, starty, divsize, divy, divprec);
    {=}

end;

function f1(x :Real) :Real;
begin
    f1 := cos(sqrt(x));
end;

function f2(x :Real) :Real;
begin
    f2 := tan(sqrt(x));
end;

const   w0 = 110; w1 = 950; h0 = 700; h1 = 50; startx = 0.2; endx = 2; dx = 0.001; { Graph }
        mleft = 50; mright = 50; mtop = 25; mbottom = 25; arrowsize = 10; divsize = 5; divx = 12; 
                    divy = 18; divprec = 3; fontsize = 1;                                       { Frame }
        titlex = 500; titley1 = 30; titley2 = 60; titlefontsize = 2;
var graphics, mode :Integer;
    yminf1, ymaxf1, yminf2, ymaxf2, ymin, ymax :Real;
    graph :GraphInfo;
begin
    graphics := D4BIT;
    mode := M1024x768;
    
    initgraph(graphics, mode, '');
    setbkcolor(BLACK);

    detminmax(@f1, yminf1, ymaxf1, startx, endx, dx);
    detminmax(@f2, yminf2, ymaxf2, startx, endx, dx);

    writeln('f1 ymin ymax: ', yminf1:0:6, ' ', ymaxf1:0:6);
    writeln('f2 ymin ymax: ', yminf2:0:6, ' ', ymaxf2:0:6);

    ymin := min(yminf1, yminf2);
    ymax := max(ymaxf1, ymaxf2);

    writeln('ymin ymax: ', ymin:0:6, ' ', ymax:0:6);

    procgraphinfo(graph, w0, w1, h0, h1, ymin, ymax, startx, endx);

    setcolor(WHITE);
    drawframe(graph, mleft, mright, mtop, mbottom, 
            arrowsize, divsize, divx, divy, divprec, fontsize);

    settextstyle(DEFAULTFONT, HORIZDIR, titlefontsize);
    settextjustify(CENTERTEXT, CENTERTEXT);
    setlinestyle(SOLIDLN, 0, THICKWIDTH);

    setcolor(RED);
    drawgraph(@f1, graph, dx);
    outtextxy(titlex, titley1, 'f1(x) = cos(sqrt(x))');

    setcolor(GREEN);
    drawgraph(@f2, graph, dx);
    outtextxy(titlex, titley2, 'f2(x) = tan(sqrt(x))');

    readkey();
end.  
