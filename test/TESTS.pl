#!/usr/bin/env perl

# -----------------------------------------------------------------------
# TESTS.pl - This script calls all the other tests in the current
# directory only. 
#
# In each directory behind the Globus CVS test module, there will be a
# TESTS.pl file for that directory which will call all the scripts in
# that directory.  The 'test-toolkit' script in side_tools/ will
# recursively search the test/ directory and run the TESTS.pl script in 
# each directory.
#
# You should only modify the @tests array below.  That's it.
#
# -----------------------------------------------------------------------

use strict;
use Cwd;

my @tests = qw(
               globus-test-check-for-commands.pl
               globus-test-check-proxy.pl
               globus-test-gram-local.pl
               globus-test-gram-remote.pl
               globus-test-gridftp-local.pl
               globus-test-gridftp-remote.pl
               );

#       globus-test-mds-local.pl
#       globus-test-mds-remote.pl

if(0 != system("grid-proxy-info -exists -hours 2 2>/dev/null") / 256)
{
    $ENV{X509_CERT_DIR} = cwd();
    $ENV{X509_USER_PROXY} = "testcred.pem";
    system('chmod go-rw testcred.pem'); 
}

foreach (@tests)
{
    system("./$_");
}
