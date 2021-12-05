unit sub MAIN( Bool :$test );

my $file = $test ?? "sample.txt" !! "input.txt";

dd $file.IO.lines
    .map({ .comb( /\d+/ ).batch( 2 ).Array>>.Int })
    .grep({ so any( [Z-] @$_ ) == 0 })
    .map({ [ [Z,] @$_ ] })
    .map({ |Range.new( |.head.sort ) <<,>> Range.new( |.tail.sort ) })
    .map( *.join: ',' )
    .Bag
    .grep( *.value > 1 )
    .elems;
