unit sub MAIN( Bool :$test, Bool :$with-diagonals = False );

my $file = $test ?? "sample.txt" !! "input.txt";

say $file.IO.lines
    # parse the line endpoints
    .map({ .comb( /\d+/ ).batch( 2 )>>.Int })
    # convert to range endpoints
    .map({ [Z,] $_ })
    # filter diagonals if requested
    .grep( $with-diagonals | *.cache.first: { [==] $_ } )
    # create the points
    .map({ | ( [...] .head ) <<,>> [...] .tail })
    # stringify, so we can bag them
    .map( *.gist ).Bag
    # filter the dangerous points
    .grep( *.value > 1 )
    # and count them
    .elems