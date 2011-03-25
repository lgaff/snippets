#define TXTBUF 4000
#define MAXIT 16

int x, y = 0;

void flushbuf(unsigned char *buffer, int bufsize);

void _kmain( void* mbd, unsigned int magic )
{
  unsigned char *haiworld = "Hai, World!\n";
  unsigned char *videoram = (unsigned char *) 0xb8000;
  
  flushbuf(videoram, TXTBUF);
}

void flushbuf(unsigned char *buffer, int bufsize) {
  int i = 0;
  while(i <= bufsize) {
    buffer[i] = " ";
    i+=2;
  }
}
/* 
 *$Cols=79; $Lines=30;
$MaxIter=16;
$MinRe=-2.0; $MaxRe=1.0;
$MinIm=-1.0; $MaxIm=1.0;
@chars=(' ','.',',','-',':','/','=','H','O','A','M','%','&','$','#','@','_');

for($Im=$MinIm;$Im<=$MaxIm;$Im+=($MaxIm-$MinIm)/$Lines)
{ for($Re=$MinRe;$Re<=$MaxRe;$Re+=($MaxRe-$MinRe)/$Cols)
  { $zr=$Re; $zi=$Im;
    for($n=0;$n<$MaxIter;$n++)
    { $a=$zr*$zr; $b=$zi*$zi;
      if($a+$b>4.0) { last; }
      $zi=2*$zr*$zi+$Im; $zr=$a-$b+$Re;
    }
    print $chars[$n];
  }
  print "\n";
}*/
