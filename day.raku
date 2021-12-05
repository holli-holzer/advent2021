unit sub MAIN(Int $day);

my $p = "2021-$day".IO;

exit if $p.e;
mkdir $p;
$p.add($_).spurt for <sample.txt input.txt part1.raku part2.raku>;

