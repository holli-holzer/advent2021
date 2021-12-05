unit sub MAIN(Int $day);

my $p = "2021-$day".IO;
my $code = 'unit sub MAIN( Bool :$test );
my $file = $test ?? "sample.txt" !! "input.txt";
';

exit if $p.e;
mkdir $p;

$p.add($_).spurt for <sample.txt input.txt>;
$p.add($_).spurt($code) for <part1.raku part2.raku>;

