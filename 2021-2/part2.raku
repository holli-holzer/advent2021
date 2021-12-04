my $aim = 0;
my @pos = 0,0;

my %d = forward => sub ($v) { @pos[0] += $v; @pos[1] += $aim * $v; },
        up      => sub ($v) { $aim -= $v; },
        down    => sub ($v) { $aim += $v; };

%d{ .[0] }( .[1] ) for "input.txt".IO.lines.map( *.split: ' ' );
say [*] @pos; 
