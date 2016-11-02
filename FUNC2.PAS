Unit Func2;

Interface

Const N = 4;
Type ArrReal = Array[1..N] of real;
     ArrInt = Array[1..N] of integer;
     AllArr = Array[1..N,1..11] of real;

     Buffer = object
            BUFT: ArrReal;
            BUFN: ArrInt;
            INDBUF: byte;
            Procedure Init;

     end;

     Main = object(Buffer)
          LAM: ArrReal;
          KOL: ArrInt;
          T: integer;
          TPOST: ArrReal;
          TOSV: real;
          NMIN: byte;
          KOTK: ArrInt;
          KOBR: ArrInt;
          TAY: real;
          TAYOB: real;
          TIME: ArrReal;
          KMIN: integer;
          locPOTK: ArrReal;
          Procedure GlobalInit;
          Procedure Init1;
          Procedure Generate(N:byte);
          Procedure BOOS;
          Procedure BAS1;
          Procedure BAS2;
     end;

     Results = object
             POTK: ArrReal;
             FTIME: ArrReal;
             AllPOTK, AllFTIME: AllArr;
             Procedure Get(m: main; Var t: text; k: integer);
             Procedure Put(M:MAIN; k: byte);
     end;

Implementation


    Procedure Main.GlobalInit;
    Begin
         LAM[1]:=1;
         LAM[2]:=2;
         LAM[3]:=1;
         LAM[4]:=1;
    End;

    Procedure Main.Init1;
    Var i: integer;
    Begin
         for i:=1 to N do begin
             KOL[i]:=0;
             KOTK[i]:=0;
             KOBR[i]:=0;
             TIME[i]:=0;
             TPOST[i]:=0;
             locPOTK[i]:=0;
             Generate(i);
         end;
         TOSV:=0; TAYOB:=0; TAY:=0; NMIN:=1; {INDBUF := 0;  }
    End;

    Procedure Main.Generate(N: byte);
    Begin
         TAY := -1/LAM[N]*ln(Random);
         TPOST[N] := TPOST[N] + TAY;
         inc(KOL[N]);
    End;

    Procedure Main.BOOS;
    Var i: byte;
        min: real;
    Begin
         NMIN:=1; min:=TPOST[1];
         for i:=2 to N do begin
             if TPOST[i]<min then begin
                min:=TPOST[i];
                NMIN:=i;
             end;
         end;
         if TOSV < TPOST[NMIN] then BAS2 else BAS1;
    End;

    Procedure Main.BAS1;
    Begin
         if INDBUF = N then begin
            inc(KOTK[NMIN]);
         end else begin
             inc(INDBUF);
             BUFT[INDBUF]:=TPOST[NMIN];
             BUFN[INDBUF]:=NMIN;
         end;
         Generate(NMIN);
    End;

    Procedure Main.BAS2;
    Var i: byte;
        max, nmax: byte;
    Begin
         TAYOB := 3 * Random;
         if INDBUF=0 then begin
            TIME[NMIN] := TIME[NMIN] + TOSV - TPOST[NMIN] + TAYOB;
            TOSV := TPOST[NMIN] + TAYOB;
            inc(KOBR[NMIN]);
            Generate(NMIN);
         end else begin
             max:=BUFN[1];
             if INDBUF > 1 then begin
                nmax:=1;
                for i:=2 to INDBUF do begin
                    if BUFN[i] > max then begin
                       max := BUFN[i];
                       nmax := i;
                    end;
                end;
                {for i:=2 to INDBUF do begin
                    if BUFN[i] = 4 then begin
                       max:=4; nmax:=i;
                    end;
                end; }
                i:=nmax;
                BUFN[i]:=0; BUFT[i]:=0;
                while  i < INDBUF do begin
                  BUFT[i]:=BUFT[i+1];
                  BUFN[i]:=BUFN[i+1];
                  i:=i+1;
                end;
             {   if INDBUF <> nmax then begin
                   for i:=INDBUF downto nmax+1 do begin
                       BUFT[i-1]:=BUFT[i];
                       BUFN[i-1]:=BUFN[i];
                   end;
                end;  }
             end;
             inc(KOBR[max]);
             TIME[max] := TIME[max] + TOSV - TPOST[max] + TAYOB;
             TOSV := TOSV + TAYOB;
             BUFT[INDBUF]:=0;
             BUFN[INDBUF]:=0;
             dec(INDBUF);
             Generate(max);
         end;
    End;

{   Procedure Main.BAS2;
   Var max, nmax,i: byte;
   Begin
        TAYOB:=random * 4;
        if INDBUF = 0 then begin
           TIME[NMIN]:=TIME[NMIN] + TPOST[NMIN] - TOSV +TAYOB;
           TOSV := TPOST[NMIN] + TAYOB;
           inc(KOBR[NMIN]);
           Generate(NMIN);
        end else begin
            max:=1; nmax:=1;
            for i:=1 to N do begin
                if BUFN[i] > max then begin
                   max:=BUFN[i];
                   nmax:=i;
                end;
            end;
            inc(KOBR[max]);
            TIME[max]:=TIME[max]+TOSV-TPOST[max]+TAYOB;
            TOSV := TOSV + TAYOB;
            i:=nmax;
            BUFN[i]:=0; BUFT[i]:=0;
            while  i < INDBUF do begin
                  BUFT[i]:=BUFT[i+1];
                  BUFN[i]:=BUFN[i+1];
                  i:=i+1;
            end;
            BUFT[INDBUF]:=0; BUFN[INDBUF]:=0;
            dec(INDBUF);
        end;
   End;
   }
    Procedure Buffer.Init;
    Var i: byte;
    Begin
         for i:=1 to N do begin
             BUFT[i]:=0;
             BUFN[i]:=0;
         end; INDBUF:=0;
    End;

   Procedure Results.Get(M:MAIN; Var t: text; k: integer);
   Var i:byte;
   Begin
        for i:=1 to N do begin
            POTK[i]:=m.KOTK[i]/m.KOL[i];
            writeln(t,' POTK[',i,'] = ',POTK[i]:3:2);
            {if m.KOBR[i] = 0 then m.KOBR[i] := 1;   }
            FTIME[i]:=abs(m.TIME[i]/m.KOBR[i]);
            if FTIME[i]=0 then FTIME[i]:=0.01;
            write(t,' FTIME[',i,'] = ',FTIME[i]:3:2);
            writeln(t);
            write(t,' KOL[',i,'] = ',m.KOL[i]);
            write(t,' KOBR[',i,'] = ',m.KOBR[i]);
            write(t,' KOTK[',i,'] = ',m.KOTK[i]);
            writeln(t);
            AllPOTK[i,k]:=POTK[i];
            AllFTIME[i,k]:=FTIME[i];
        end;
        writeln(t);
   End;

   Procedure Results.Put(M:MAIN; k: byte);
   Var i: byte;
   Begin
        writeln(k, ' realization');
        for i:=1 to N do begin
            POTK[i]:=m.KOTK[i]/m.KOL[i];
            write(' POTK[',i,'] = ',POTK[i]:3:2);
            FTIME[i]:=abs(m.TIME[i]/m.KOBR[i]);
            write(' FTIME[',i,'] = ',FTIME[i]:3:2);
            writeln;
            write(' KOL[',i,'] = ',m.KOL[i]);
            write(' KOBR[',i,'] = ',m.KOBR[i]);
            write(' KOTK[',i,'] = ',m.KOTK[i]);
            writeln;
        end;
        writeln;
   End;

begin
end.