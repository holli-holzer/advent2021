unit sub MAIN( Bool :$test, Bool :$with-diagonals = False );

my $file = $test ?? "sample.txt" !! "input.txt";

say $file.IO.lines
    .map({ .comb( /\d+/ ).batch( 2 ).Array>>.Int })
    .map({ cache [Z,] $_ })
    .grep( $with-diagonals | *.first: { [==] $_ } )
    .map({ | ( [...] .head ) <<,>> [...] .tail })
    .map( *.gist )
    .Bag
    .grep( *.value > 1 )
    .elems