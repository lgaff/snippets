#################
#   CONSTANTS   #
#################

$ram         =   2048;                  # Amount of RAM available to the system in bytes
$diskfile    =   "vmdisk.img";          # Hard disk filename
$rom         =   "vmrom.bin";           # ROM file containing bootstrapper code
$columns     =   40;
$rows        =   25;

############################################
#           INSTRUCTION FORMATS            #
############################################

############################################
#  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |       #
#  |  OPERAND  | RX| RY| FUNCTION  |       #
#  |  OPERAND  | RX|   IMMEDIATE   |       #
#  |  OPERAND  |    ADDR/OFFSET    |       #
############################################
############################################
#  INSTR |  OP |   PSEUDOCODE              #
#   000  | --  | SEE ALU INSTRUCTIONS      #
#   001  | OUT | DISP[IMM] = RX            #
#   010  | LUI | RX = IMM << 4             #
#   011  | ORI | RX = RX | IMM             #
#   100  | LDX | RX = RAM[IMM]             #
#   101  | STX | RAM[IMM] = RX             #
#   110  | JMP | PC = (PC & 0xE0) | ADDR   #
#   111  | BEQ | PC += RX == RY ? OFFSET:0 #
############################################
############ ALU INSTRUCTIONS ##############
#  FUNCT |  OP |   PSEUDOCODE              #
#   000  |  OR | RX = RX | RY              #
#   001  | XOR | RX = RX ^ RY              #
#   010  | AND | RX = RX & RY              #
#   011  | ADD | RX = RX + RY              #
#   100  | SRL | RX = RY >> 1              #
#   101  | SRA | RX = RY / 2               #
#   110  | NOT | RX = ~RY                  #
#   111  | NEG | RX = -1 * RY              #
############################################

@instructions = (
                    "alu($IR^0xF8,$IR^0xEF>>4,$IR^0xF7>>3)",
                    "$dispram[$IR^0xF0] = $reg[$IR^0xEF>>4]",
                    "$reg[$IR^0xEF>>4] ^= 0xF0;$reg[$IR^0xEF] ^= $IR^0xF0<<4",
                );
############################################
# Initialise (zero) the ram & registers
@mainmem = ();
@dispram = ();
@reg     = (0x7F, 0x7F);
$PC = 0x00;
$IR = 0x00;

$res = $columns * $rows - 1;
foreach $cell (0..$res) 
{
    $dispram[$cell] = 0x20;             # MAIN DISPLAY RAM INITIAL STATE IS SPACES.
}
foreach $cell (0..$ram-1) 
{
    $mainmem[$cell] = 0x00;
}
sub binary 
{
    local $string = "";
    my $arg = shift;
    if ($arg > 255) { };
    my $xp = 7;
    while ($xp > 0) {
        local $pow = 2 ** $xp;
        $string .= $arg - $pow >= 0 ? "1" : "0";
        $arg = $arg % $pow;
        $xp--;
    }
    $string .= "$arg";
    return $string;
}
sub decode_op
{
    local $instruction = shift;
    my $rx = 255;
    my $ry = 255;
    my $fn = 255;
    my $im = 255;
    my $ad = 255;
    my $operand = $instruction >> 5;
    if ($operand == 0) 
    {
    #    print sprintf("%02x\n", $instruction);
        $rx = ($instruction & 0x10) >> 4; #should be 0 right now...
    #    print sprintf("%02x ", $rx);
        $ry = ($instruction & 0x08) >> 3;
    #    print sprintf("%02x ", $ry);
        $fn = $instruction & 0x07;
    #    print sprintf("%02x\n", $fn);
        return ($operand, $rx, $ry, $fn);
    }
    elsif (($operand >= 1) && ($operand <= 5)) 
    {
        $rx = $instruction & 0x10 >> 4;
        $im = $instruction & 0x0F;
        return ($operand, $rx, $im);
    }
    elsif ($operand >= 6)
    {
        $ad = $instruction & 0x1F;
        return ($operand, $ad);
    }
}
sub alu
{
    my $src = pop;
    my $dst = pop;
    my $fn  = pop;
    if ($fn == 0)    {$reg[$dst] |= $reg[$src]}
    elsif ($fn == 1) {$reg[$dst] ^= $reg[$src]}
    elsif ($fn == 2) {$reg[$dst] &= $reg[$src]}
    elsif ($fn == 3) {$reg[$dst] += $reg[$src]}
    elsif ($fn == 4) {$reg[$dst] = $reg[$src] >> 1}
    elsif ($fn == 5) {}                                 # NO WORKIE
    elsif ($fn == 6) {$reg[$dst] = ~$reg[$src]}
    elsif ($fn == 7) {
    print "$reg[$dst] $reg[$src] :: ";
    $reg[$dst] = -1 * $reg[$src];
    print "$reg[$dst] $reg[src]\n";
    }
}
sub refresh_ui 
{ # UPDATE THE DISPLAY. TAKES NO ARGUMENTS
    # draw top line
    foreach $cell (1..$columns) 
    {
        print "-";
    }
    # dump registers
    print "\n";
    print "PC " . binary($PC) . "     " . "A " . binary($reg[0]);
    print "\n";
    print "IR " . binary($IR) . "     " . "B " . binary($reg[1]);
    print "\n";
    for $row (0..$rows-1) 
    {
        for $col (0..$columns-1) 
        {
            $cell = $row * $rows + $col;
            print chr($dispram[$cell]);
        }
        print "\n";
    }
    print "\n";
    print "-" for (1..$columns);
}
    
# MAINLINE LOOP
{
LINE:    getc;
    $IR = 0x17;
    @ins = decode_op($IR);
    print scalar(@ins) . $/;
    if (scalar(@ins) == 4) 
    {
        alu($ins[3], $ins[2], $ins[1]);
    }
    
    refresh_ui();
    $PC++;
    $PC %= 256;
    #goto LINE;
}
