say +("i".IO.lines.map({.comb(/\d+/).batch(2)».Int}).map({[Z,] $_}).grep({@$_.first:{[==] $_}}).map({|[«,»] .map({[...] $_})}).map(*.Str).Bag.grep(*.value>1));
say +("i".IO.lines.map({.comb(/\d+/).batch(2)».Int}).map({[Z,] $_}).map({|[«,»] .map({[...] $_})}).map(*.Str).Bag.grep(*.value>1));
