sub f( $v ) {
    my @d = [Z,] "sample.txt".IO.lines.map: *.comb;
    my $b = +@d[0] div 2;
    @d.map({ +( $v.so == ( .sum > $b ) ) }).join.parse-base(2);
}

say f(0) * f(1)