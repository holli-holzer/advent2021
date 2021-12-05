say +("i".IO.lines.map({.comb(/\d+/).batch(2)>>.Int}).map({[Z,] $_}).grep(*.cache.first:{[==] $_}).map({|[<<,>>] ([...] .[0]),[...] .[1]}).map(*.Str).Bag.grep(*.value>1));
say +("i".IO.lines.map({.comb(/\d+/).batch(2)>>.Int}).map({[Z,] $_}).map({|[<<,>>] ([...] .cache.[0]),[...] .[1]}).map(*.Str).Bag.grep(*.value>1));
