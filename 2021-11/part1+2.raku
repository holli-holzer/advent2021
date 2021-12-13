constant width =
constant height = 10;

my \input = [ $*IN.comb: /\d/ ];
my \coord = [ ^ width * height ];
my \nbors = [ coord».&nbors-of ];

{   # PART 1
    my \i = input.clone;
    my \f = [ False xx +i ];
    say sum ( 1..100 ).map: { step i, f } }

{  # PART 2
    my \i = input.clone;
    my \f = [ False xx +i ];
    say ( 1..^Inf ).first: { step i, f; i.sum == 0 } }

sub step( \data, \flashed )
{
    data »+=» 1;
    flashed »=» False;

    while my \flashpoints = coord.grep: { !flashed[ .item ] && data[ .item ] > 9 }
    {
        flashed[ flashpoints ] »=» True;
        data[ nbors[ flashpoints; * ] ] »+=» 1;
    }

    +( data[ coord.grep: { flashed[ .item ] } ] »=» 0 )
}

sub nbors-of( \position )
{
    constant candidates = [ (-1..1 X -1..1).grep: *.all != 0 ];

    candidates
        .map({[ .list Z+ position % width, position div width ]})
        .grep({ 0 <= .head < width })
        .grep({ 0 <= .tail < height })
        .map({ .head + .tail * width })
        .list
}