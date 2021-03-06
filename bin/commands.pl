#!/usr/bin/perl 

use lib "/home/velbus/velserver/lib" ;
our %global ;
$global{BaseDir} = "/home/velbus/velserver" ;

use Getopt::Long ;
&GetOptions ('option=s' => \$global{opts}{option} ,
             'help' => \$global{opts}{help} ) or &print_help ;

# Print help en exit dan
sub print_help {
   print "Possible options:

   -o = 
      scan = scan all modules on the bus
      status = get status off all modules
      date = broadcast date and time
      openHAB = create the openHAB items file
         it also prints the file
   
" ;
   exit ;
}  

if ( defined $global{opts}{help} ) {
   &print_help ;
}  

use strict;
use POSIX qw/strftime/;

use Velbus ;

&init () ;

my $sock = &open_socket ;

if ( $global{opts}{option} eq "scan" ) {
   &scan($sock) ;
} elsif ( $global{opts}{option} eq "status" ) {
   &update_module_status($sock) ;
} elsif ( $global{opts}{option} eq "date" ) {
   &broadcast_datetime($sock) ;
} elsif ( $global{opts}{option} eq "openHAB" ) {
   &openHAB_config () ;
   my $openHAB = &openHAB () ;
   print $openHAB ;
} else {
   &print_help ;
}

