enum State( :!incomplete, :complete );
constant drawn = -1;
constant width = 5;

my ( $numbers, $boards ) =
    .head.comb( /\d+/ ),
    .skip.comb( /\d+/ ).batch( width² )>>.Array
        with $*IN.lines.cache;

for @$numbers -> $number
{
    given @$boards.classify( *.&draw: $number )
    {
        say .{ State::complete }.map( *.grep( * != drawn ).sum * $number )
            if .{ State::complete }:exists;

        $boards = .{ State::incomplete } || exit;
    }
}

sub draw( $board, $drawn )
{
    state @rows = (^width²).batch: width;
    state @cols = [Z] @rows;

    for @$board -> $number is rw
    {
        $number = drawn if $number eq $drawn;
    }

    State( so ( @cols | @rows ).first: { $board[ .Array ].all == drawn } );
}