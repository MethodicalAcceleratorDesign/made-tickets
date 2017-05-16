#! /usr/bin/env perl

# Usage:
# ./select.pl FIELD_NAME <twissfile.twiss

my $select = uc($ARGV[0]);
my %twiss;

# read twiss file:
my @fields;
my @values;
while (<STDIN>) {
    @fields = split('\s+') if (s/^\* NAME\s*//);
    @values = split('\s+') if (s/^\s*"$select"\s*//);
}
@twiss{@fields} = @values;

# print values in bash/python/madx compatible syntax
print join("\n", map {$_.'='.$twiss{$_}.';'} keys(%twiss)) . "\n";

