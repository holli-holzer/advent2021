my @lines = 'input.txt'.IO.lines;
my @drawn = @lines.first.comb( /\d+/ );
my @board = @lines.skip.map( *.comb( /\d+/ ).Slip ).batch( 25 )>>.Array;
my @rows  = map { .item * 5 ..^ .item * 5 + 5 }, ^5;
my @cols  = [Z,] @rows;

sub is-winner( $board, $drawn )
{
    for @$board -> $number is rw
    {
        $number = -1 if $number eq $drawn;
    }

    so ( @cols | @rows ).first: { $board[ .Array ].all < 0 }
}

for @drawn -> $drawn
{
    given @board.classify( *.&is-winner: $drawn )
    {
        if .{True}:exists
        {
            say .{True}.map: { [*] $drawn, [+] .grep( * > 0 ) };
        }

        if .{False}:exists
        {
            @board = .{False}.Array;
        }
        else
        {
            last
        }
    }
}