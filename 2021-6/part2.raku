unit sub MAIN( Bool :$test );
my $file = $test ?? "sample.txt" !! "input.txt";
