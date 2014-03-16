use strict;
use warnings;
use Test::More;
use Win32::Job;
use Config;
use File::Temp qw/ tempfile /;

{
    my @outs = map [tempfile], 1 .. 2;
    my $job = Win32::Job->new;
    spawn_perl( $job, qq{perl -e "print 5$_"}, { stdout => $outs[$_][0] } ) for 0 .. 1;
    ok $job->run( 5 * 60 ), "processes succeeded";
    close $_->[0] for @outs;
    @outs = map { open my $fh, '<', $_->[1]; local $/; my $s = <$fh>; $s } @outs;
    is $outs[0], 50, "first output is correct";
    is $outs[1], 51, "second output is correct";
}

{
    my $job = Win32::Job->new;
    my $t   = time;
    spawn_perl( $job, qq{perl -e "sleep 5"} );
    ok !$job->run( 2 ), "process was timed out";
    cmp_ok time - $t, '<', 5, "less than the sleep time was used";
}

done_testing;

sub spawn_perl {
    my ( $job, @args ) = @_;
    $job->spawn( $Config{perlpath}, @args );
    return;
}
