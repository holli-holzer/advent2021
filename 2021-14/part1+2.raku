my ( \o, \r ) =
    .head.comb.List,
    .tail.comb( /\w/ ).map( -> $a, $b, $c { "$a$b" => [ "$a$c", "$c$b" ] } ).Hash
        with cache $*IN.slurp.split: "\n\n";

sub day14( \n )
{
    my %d = o.rotor( 2 => -1 ).map( *.join ).Bag;

    %d = [⊎] %d.map({ r.{.key} »=>» .value }) for ^n;

    .Bag.values.minmax.elems - 1
        with ( o.tail => 1, |%d ).map: {
            .key.substr(0, 1) => .value
        };
}

say day14 10;
say day14 40;