my @I='i'.IO.lines;my \D=@I[0].comb(/\d+/);my @B=@I.skip.comb(/\d+/).batch(25)>>.Array;my @R=|@$_,|[Z,] @$_ with map {$_*5..^$_*5+5},^5;
sub d($b,$n){$_=$_~~$n??-1!!$_ for @$b;+so @R.grep({$b[@$_].all <0})}
for D ->\d {with @B.classify(*.&d: d) {dd .{1}.map({d*.grep(*>0).sum}) if .{1}:exists;@B=@(.{0})}}