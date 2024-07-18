#!/usr/bin/perl
use inc::Module::Install;

author undef;
license 'CC0';

all_from 'lib/PerlYuYan.pm';
readme_from 'lib/PerlYuYan.pm';

requires qw( Filter::Simple::Compile 0.02 );

WriteAll;
