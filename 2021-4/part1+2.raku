unit sub MAIN( Bool :$test );

my $file = $test ?? 'sample.txt' !! 'input.txt';

enum State( :!incomplete, :complete );
constant drawn = -1;
constant width = 5;

my ( $numbers, $boards ) =
    .first.comb( /\d+/ ),
    .skip.comb( /\d+/ ).batch( width² )>>.Array
        with $file.IO.lines.cache;

for @$numbers -> $number
{
    given @$boards.classify( *.&draw: $number )
    {
        say .{ State::complete }.map({ $number * [+] .grep: * != drawn })
            if .{ State::complete }:exists;

        $boards = .{ State::incomplete } || exit;
    }
}

sub draw( $board, $drawn )
{
    state @rows  = map { .item * width ..^ .item * width + width }, ^width;
    state @cols  = [Z,] @rows;

    for @$board -> $number is rw
    {
        $number = drawn if $number eq $drawn;
    }

    State( so ( @cols | @rows ).first: { $board[ .Array ].all == drawn } );
}