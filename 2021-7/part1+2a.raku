my ( \範囲, \カニ ) = .minmax, .Bag with $*IN.comb( /\d+/ )>>.Int;
for ^範囲.max.succ, [\+] ^範囲.max.succ -> \費用 {
    say min map -> \身長 { [+] カニ.map: { .value * 費用[ abs 身長 - .key ] } }, [...] 範囲 }