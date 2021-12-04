my @d = "sample.txt".IO.lines.map( *.comb.Array );
my $b = +@d div 2;
my @r = map { @d[*;$_] }, ^+@d[0];
my @ɣ = @r.map: { +( .sum > $b ) };
my @ɛ = @r.map: { +( .sum < $b ) };
say [*] ( @ɣ, @ɛ )>>.join>>.parse-base(2);
