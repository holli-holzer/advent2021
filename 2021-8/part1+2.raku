enum Digits <ABCEFG CF ACDEG ACDFG BCDF ABDFG ABDEFG ACF ABCDEFG ABCDFG>;

my @input = $*IN.lines.map: {
    .[0 ..^ *- 4, *- 4 ..*] with .comb(/\w+/).map: *.comb.sort.list
};

say [+] @input.map: &part1;
say [+] @input.map: &part2;

sub part1( $record )
{
    + $record.tail.map( *.elems ).grep: * == 2 | 3 | 4 | 7;
}

sub part2( $record )
{
    my %segments = deduce-segments $record.head;
    [~] $record.tail.map: { Digits.enums{ [~] sort .map: { %segments{$_} } } }
}


sub deduce-segments( $garbled-segments )
{
    my %sgm;

    given $garbled-segments.classify: *.elems
    {
        %sgm<A> = [∖] |.{3}, |.{2};
        my $cde = cache @( .{6}.map: |* ).Bag.grep( *.value == 2 ).values.map: *.key;
        my $dg  = [∖] ( [∩] |.{5} ),  %sgm<A>;
        my $de  = [∖] |.{7},  ( [⊎] %sgm<A>, |.{4} ) ⊖ $dg;
        %sgm<C> = [∖] $cde, $de;
        %sgm<D> = [∩] $dg, $de;
        %sgm<E> = [∖] $cde, |%sgm<D C>;
        %sgm<G> = [∖] $dg, %sgm<D>;
        %sgm<F> = [∖] |.{3}, |%sgm<A C>;
        %sgm<B> = [∖] |.{7}, [⊎] |%sgm<A C D E F G>;

        %sgm.map({ .value.head.key => .key }).Hash;
    }
}