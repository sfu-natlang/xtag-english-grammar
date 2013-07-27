#!/usr/local/bin/perl5
# -*- perl -*-

$labelfile = shift(@ARGV);
print STDERR "using $labelfile\n";

@label_tbl = ();
%label_hash = ();
$label_idx = 0;
open (F, "<$labelfile") or die "cannot open $labelfile\n";
while (<F>) { chomp; $label_hash{$_} = $label_idx; $label_tbl[$label_idx++] = $_; }
print STDERR "read $label_idx labels\n";
close (F);

foreach $file (@ARGV) {
    rename ($file, "$file.orig") or die "cannot rename $file\n";
    open (IN, "<$file.orig") or die "cannot open $file.orig\n";
    open (OUT, ">$file") or die "cannot open $file for output\n";
    while (<IN>)
    {
	if (/\\label/) {
	    /\\label\{([^\}]*)\}/;
	    $key = $1;
	    s/\\label\{[^\}]*\}/\\label\{$label_hash{$key}\}/go;
	}
	if (/\\ref/) {
	    /\\ref\{([^\}]*)\}/;
	    $key = $1;
	    s/\\ref\{[^\}]*\}/\\ref\{$label_hash{$key}\}/go;
	}
	print OUT;
    }
    close(IN);
    close(OUT);
}
