#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Win32::Job' );
}

diag( "Testing Win32::Job $Win32::Job::VERSION, Perl $], $^X" );
