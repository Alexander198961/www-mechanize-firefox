#!perl -w
use strict;
use WWW::Mechanize::Firefox;
use Test::More;

my $mech = eval { WWW::Mechanize::Firefox->new( 
    autodie => 0,
    #log => [qw[debug]]
)};

if (! $mech) {
    my $err = $@;
    plan skip_all => "Couldn't connect to MozRepl: $@";
    exit
} else {
    plan tests => 2;
};

$mech->get_local('50-form2.html');
$mech->form_number(1);
my $the_form_dom_node = $mech->current_form;
my $button = $mech->selector('#btn_ok', single => 1);
isa_ok $button, 'MozRepl::RemoteObject::Instance', "The button image";

ok $mech->submit, 'Sent the page';