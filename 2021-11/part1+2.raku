constant w = constant h = 10;
constant n = [ (-1..1 X -1..1).grep: *.all != 0 ];

my \in = [ 'sample.txt'.IO.comb(/\d/)>>.Int ];
my \co = [ ^ w * h ];
my \nb = [ co.map: *.&neighbours ];

{
    my \i = in.clone;
    my \f = [ False xx +i ];
    say sum (1..100).map: { step i, f };
}

{
    my \i = in.clone;
    my \f = [ False xx +i ];
    say (1..^Inf).first: { step i, f; i.sum == 0 };
}

sub step( \i, \f )
{
    i »+=» 1;
    f »=» False;

    while my \P = co.grep: { !f[$_] && i[$_] > 9 }
    {
        f[ |P ] »=» True;
        i[ |P.map: { |nb[$_] } ] »+=» 1;
    }

    +( i[ co.grep: { f[$_] } ] »=» 0 );
}

sub neighbours( \i )
{
    my ( \x, \y ) = i % w, i div w;

    n.map({[ .list Z+ x, y ]})
     .grep({ 0 <= .head < w })
     .grep({ 0 <= .tail < h   })
     .map({ .head + .tail * w })
     .list
}