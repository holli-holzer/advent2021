my @a[9];@a[$_]++ for 'i'.IO.comb: /\d/;say sum @a=|@a.skip,0 Z+ |(0 xx 6),@a[0],0,@a[0] for ^80;