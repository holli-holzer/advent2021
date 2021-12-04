my %d = forward => (1,0),
        up      => (0,-1),
        down    => (0,1);

say [*] [Z+] "input.txt".IO.lines.map( *.split: ' ' ).map({ %d{ .[0] } >>*>> .[1] });

