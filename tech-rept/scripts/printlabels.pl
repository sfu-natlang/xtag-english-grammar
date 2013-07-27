#!/usr/local/bin/perl5
# -*- perl -*-

foreach $file (@ARGV) {
    open (IN, "<$file") or die "cannot open $file\n";
    while (<IN>)
    {
	chomp;
	s/([^%]*)%.*/\1/o;
	next if /\\renewcommand/;
	if (/\\label[ \t]*\{/) {
	    m/\\label[ \t]*\{([^\}]*)\}/go;
	    print "$1\n";
	}
    }
    close(IN);
}
