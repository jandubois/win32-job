use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

unless ($^O eq "MSWin32" || $^O eq "cygwin") {
    die "OS unsupported\n";
}

my %param = (
    NAME         => 'Win32::Job',
    VERSION_FROM => 'Job.pm',
    PREREQ_PM     => {
        'base' => 0,
        'constant' => 0,
    },
    AUTHOR => 'Jan Dubois <jand@activestate.com>',
    LICENSE => 'perl',
);
WriteMakefile(%param);
