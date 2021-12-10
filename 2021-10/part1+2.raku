enum LineStatus< corrupt incomplete valid >;

class X::LineMalformed is Exception
{
    has $.pos;
    has $.repair;
}

grammar G
{
    token TOP      { :my @*rep; <balanced> }
    token balanced { (:r  <braces> || <brackets> || <curlies> || <pointies> )+ }
    token braces   { \( { @*rep.push: ')' } ~ \) <balanced>* { @*rep.pop } }
    token brackets { \[ { @*rep.push: ']' } ~ \] <balanced>* { @*rep.pop } }
    token curlies  { \{ { @*rep.push: '}' } ~ \} <balanced>* { @*rep.pop } }
    token pointies { \< { @*rep.push: '>' } ~ \> <balanced>* { @*rep.pop } }

    method FAILGOAL($goal)
    {
        die X::LineMalformed.new( pos => self.pos, repair => @*rep.reverse.list )
    }
}

sub parse( \line )
{
    G.parse: line;

    return %( line => line, status => LineStatus::valid );

    CATCH { default { return %(
        at     => .pos,
        fix    => .repair,
        char   => line.substr( .pos, 1 ),
        status => LineStatus( +( line.chars == .pos ) )
    )}}
}

my %i = ')' => 1, ']' => 2,  '}' => 3,    '>' => 4;
my %c = ')' => 3, ']' => 57, '}' => 1197, '>' => 25137;

my %l = $*IN.lines.map( &parse ).classify( *.<status> );

.sum.say
    with %l{ LineStatus::corrupt }.values.map: {
        %c{ .<char> }};

.[ .elems div 2 ].say
    with sort %l{ LineStatus::incomplete }.values.map: {
        ( 0, |.<fix> ).reduce: { $^a * 5 + %i{ $^b } }};