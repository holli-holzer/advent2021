unit sub MAIN( $days, Bool :$test );

my $file = $test ?? "sample.txt" !! "input.txt";

my @ages = 0 xx 9;

@ages[ .item ]++
    for $file.IO.comb: /\d/;

say sum( @ages .= &next-day )
    for 1 .. $days;

sub next-day( \ages )
{
    |ages.skip, 0 Z+
    0, 0, 0, 0, 0, 0, ages.head, 0, ages.head
}