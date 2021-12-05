unit sub MAIN(Bool $diagonals=False);
say "input".IO.lines
.map({.comb(/\d+/).batch(2).Array>>.Int})
.map({cache [Z,] $_})
.grep($diagonals|*.first: { [==] $_ })
.map({|[<<,>>] ([...] .head),[...] .tail})
.map(*.gist)
.Bag
.grep(*.value > 1)
.elems