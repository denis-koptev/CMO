Unit Menu;

Interface

Uses Graph, crt, FUNC2;

Type Menu1 = object
     answ: integer;
     back, but1, but2, but3, text, sel: word;
     Procedure Init;
     Procedure Draw(M: MAIN);

end;

Implementation

Procedure Menu1.Init;
Var gd, gm: integer;
Begin
     gd := 0;
     {detectgraph(gd, gm); }
     gm := 1;
     Initgraph(gd, gm, 'C:\TP\BGI');
     if graphresult <> 0 then begin
        writeln('ERROR'); HALT;
     end;
End;

Procedure Menu1.Draw(M: MAIN);
Var local: byte;
    skmin, slam: string;
    i: byte;
begin
     cleardevice;
     setcolor(text);
     settextstyle(3,0,7);
     OutTextXY(257, 5, 'CMO');
     settextstyle(2,0,9);
     setfillstyle(1, but1);
     Bar(30, 90, 200, 150);
     setcolor(black);
     outtextxy(48,105, 'SETTINGS');
     setfillstyle(1, but2);
     Bar(235, 90, 405, 150);
     outtextxy(280,105, 'START');
     setfillstyle(1, but3);
     Bar(440, 90, 610, 150);
     outtextxy(468,105, 'RESULTS');
     setlinestyle(0,0,3);
     setcolor(sel);
     rectangle(30, 90, 200, 150);
     answ := 1; local := 1;
           setcolor(red);
           setfillstyle(1, 7);
           line(20,340, 620, 340);
           bar(30, 360, 610, 450);
           settextstyle(0,0,1);
           outtextxy(40,370, 'STATISTICS:');
           line(320, 365, 320, 445);
           outtextxy(400,385,'Press ESC to exit');
           outtextxy(360,400,'Press Backspace to get help');
           outtextxy(385,415,'Use arrows to control');
     while true do begin
           settextstyle(0,0,0);
           setcolor(red);
           str(M.KMIN, skmin);
           skmin:= 'KMIN: ' + skmin;
           outtextxy(45,385, skmin);
           for i:=1 to N do begin
               str(i,slam);
               slam:=slam+' source LAM: ';
               str(M.LAM[i]:2:1,skmin); {Переменная отработала выше,
               поэтому можно использовать для других целей}
               slam:=slam+skmin;
               outtextxy(45,390+i*10,slam);
           end;
           case answ of
                1: begin
                   setfillstyle(1, 0);
                   bar(25, 175, 630, 310);
                   setfillstyle(1,red);
                   bar(30,180,200,230);
                   setcolor(white);
                   settextstyle(2, 0, 8);
                   outtextxy(37,192,'CHANGE KMIN');
                   bar(30, 250, 200, 300);
                   outtextxy(42,262,'CHANGE LAM');
                   if local>1 then begin
                      rectangle(30,180+70*(local-2),200,230+70*(local-2));
                      setcolor(black);
                      rectangle(30, 90, 200, 150);
                   end else begin
                       setcolor(sel);
                       rectangle(30, 90, 200, 150);
                   end;
                end;
                2: begin
                   setfillstyle(1, 0);
                   bar(25, 175, 630, 310);
                   setfillstyle(1,green);
                   bar(235,180,405,230);
                   setcolor(white);
                   settextstyle(2, 0, 8);
                   outtextxy(273,192,'GRAPHIC');
                   bar(235, 250, 405, 300);
                   outtextxy(290,262,'TEXT');
                   if local>1 then begin
                      rectangle(235,180+70*(local-2),405,230+70*(local-2));
                      setcolor(black);
                      rectangle(235, 90, 405, 150);
                   end else begin
                       setcolor(sel);
                       rectangle(235, 90, 405, 150);
                   end;
                end;
                3: begin
                   setfillstyle(1, 0);
                   bar(25, 175, 630, 310);
                   setfillstyle(1,1);
                   bar(440,180,610,230);
                   setcolor(white);
                   settextstyle(2, 0, 8);
                   outtextxy(482,192,'GRAPHS');
                   bar(440, 250, 610, 300);
                   outtextxy(489,262,'TABLE');
                   if local>1 then begin
                      rectangle(440,180+70*(local-2),610,230+70*(local-2));
                      setcolor(black);
                      rectangle(440, 90, 610, 150);
                   end else begin
                       setcolor(sel);
                       rectangle(440, 90, 610, 150);
                   end;
                end;
           end;
           case readkey of
                #27: halt;
                #77: begin
                     local := 1;
                     if answ=1 then begin
                        setcolor(back);
                        rectangle(30, 90, 200, 150);
                        setcolor(sel);
                        rectangle(235, 90, 405, 150);
                     end;
                     if answ=2 then begin
                        setcolor(back);
                        rectangle(235, 90, 405, 150);
                        setcolor(sel);
                        rectangle(440, 90, 610, 150);
                     end;
                     if answ=3 then begin
                        setcolor(back);
                        rectangle(440, 90, 610, 150);
                        setcolor(sel);
                        rectangle(30, 90, 200, 150);
                     end;
                     inc(answ); if answ > 3 then answ :=1;
                end;
                #75: begin
                     local := 1;
                     if answ=3 then begin
                        setcolor(back);
                        rectangle(440, 90, 610, 150);
                        setcolor(sel);
                        rectangle(235, 90, 405, 150);
                     end;
                     if answ=2 then begin
                        setcolor(back);
                        rectangle(235, 90, 405, 150);
                        setcolor(sel);
                        rectangle(30, 90, 200, 150);
                     end;
                     if answ=1 then begin
                        setcolor(back);
                        rectangle(30, 90, 200, 150);
                        setcolor(sel);
                        rectangle(440, 90, 610, 150);
                     end;
                     answ:=answ-1;
                     if answ < 1 then answ :=3;
                     end;
                #13: begin
                     case answ of
                          1: if (local = 1)or(local = 2) then answ:=1
                          else answ:=2;
                          2: if (local = 1)or(local = 2) then answ:=3
                          else answ:=4;
                          3: if (local = 1)or(local = 2) then answ:=5
                          else answ:=6;
                     end; break;
                end;
                {Scheme of answers:
                1: change kmin;
                2: change lams;
                3: start graphic;
                4: start text;
                5: watch graphs;
                6: watch table
                7: show help}
                #72: begin dec(local); if local < 1 then local:=3; end;
                #80: begin inc(local); if local > 3 then local:=1; end;
                #8: begin answ := 7; break; end;
           end;
     end;
end;

begin
end.