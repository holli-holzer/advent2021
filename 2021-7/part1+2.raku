my ( $range, $bag ) = .minmax, .Bag with $*IN.comb(/\d+/)>>.Int;
for ^Inf, [\+] ^Inf -> $cost {
    say min map -> $t { [+] $bag.map: { .value * $cost[ abs $t - .key ] } }, [...] $range }