my @lines = 'input.txt'.IO.lines;
my @drawn = @lines.first.comb: /\d+/;
my @board = .batch( 25 )>>.Array with @lines.skip.comb: /\d+/;

sub draw( $board, $drawn )
{
    state @rows  = map { .item * 5 ..^ .item * 5 + 5 }, ^5;
    state @cols  = [Z,] @rows;

    for @$board -> $number is rw
    {
        $number = -1 if $number eq $drawn;
    }

    ( @cols | @rows ).first({ $board[ .Array ].all < 0 }).so
        ?? 'complete'
        !! 'incomplete';
}

for @drawn -> $drawn
{
    given @board.classify( *.&draw: $drawn )
    {
        say .<complete>.map({ $drawn * [+] .grep: * > 0 })
            if .<complete>:exists;

        @board = .<incomplete>:exists
            ?? .<incomplete>.Array
            !! last;
    }
}