unit sub MAIN($diagonals);
say +("input.txt".IO.lines
.map({.comb(/\d+/).batch(2)>>.Int})
.map({[Z,] $_})
.grep($diagonals|*.cache.first: { [==] $_ })
.map({|[<<,>>] ([...] .head),[...] .tail})
.map(*.gist)
.Bag
.grep(*.value > 1))