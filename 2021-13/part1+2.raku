my ( \points, \instructions )  =  $*IN
    .slurp
    .subst( "fold along ",  :g )
    .split( /\n\n/ )
    .map: {[
        .lines.map: { .split: / \, | \= / }
    ]};

my \width  = points.[*;0]>>.Int.max;
my \height = points.[*;1]>>.Int.max;

my \matrix = [ [ 0 xx width + 1  ] xx height + 1 ];
matrix[ .tail; .head ] = 1 for |points;

# PART 1
matrix .= &fold: |instructions.first;
say  +matrix[*;*].grep: * > 0;

# PART 2
matrix .= &fold: |.item for |instructions.skip;
say .join for matrix>>.map: { +( so + $_ > 0 ) || ' ' };

multi  fold( \mx, 'y', \at )
{
    mx[ ^at ] »+» reverse mx[ at ^.. * ]
}

multi  fold(  \mx, 'x', \at )
{
    [Z] fold ( [Z] mx ), 'y', at
}