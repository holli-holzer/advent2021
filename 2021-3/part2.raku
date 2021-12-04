sub f( $v ) {
    my @d = "sample.txt".IO.lines.map: *.comb.Array>>.Int;

    for ^+@d[0] -> \i
    {
        my \r = @d[*;i];
        my \v = +r div 2 > r.grep: *.so;
        @d .= grep: { .[i].so == ( $v == v ) };
        return @d[0].join.parse-base(2) if
            @d == 1;
    }
}

say f(0) * f(1);