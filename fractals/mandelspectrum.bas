10 LET max=7
20 FOR x=0 TO 255
30 FOR y=0 TO 175
40 LET u=x/127.5-1.5
50 LET v=y/87.5-1
60 LET x0=u
70 LET y0=v
80 LET i=0
90 LET a=x0*y0
100 LET b=y0*y0
110 IF a+b>4 OR i>=max THEN GO TO 160
120 LET y0=2*x0*y0+v
130 LET x0=a-b+u
140 LET i=i+1
150 GO TO 90
160 IF i<max THEN GO TO 190
170 LET i=0
171 GO TO 190
180 IF i>16 THEN GO SUB 250
190 INK i
200 PLOT x,y
210 NEXT x
220 NEXT y
230 STOP
250 LET tmp= INT(i/16)
260 LET i=i-(tmp*16)
270 RETURN
