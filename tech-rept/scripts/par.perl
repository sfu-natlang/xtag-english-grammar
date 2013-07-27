#!/usr/local/bin/perl5

$remove_enumsent = 1;
$convert_psfig = 1;
$exnum = 0;
$inalltt = 0;

foreach $file (@ARGV) {
    print STDERR "reading $file ...\n";
    print STDERR "writing to /mnt/linc/xtag/work/doc/tech-rept/html/$file ...\n";
    open(IN, $file);
    open(OUT, ">/mnt/linc/xtag/work/doc/tech-rept/html/$file") or die "Can't open output file for $file.\n";

    @sexpr = ();
    $i = $lcount = $rcount = 0;
    $partialsexpr = "";

    while (<IN>) {
        $lcount += (tr/{//) ;
		    $rcount += (tr/}//) ;
        $partialsexpr .= $_ ; 
        if (($lcount - $rcount) == 0) {
            $lcount = 0 ; $rcount = 0 ; 
            $sexpr[$i] = $partialsexpr ; $i++ ;
            $partialsexpr = "" ;
        }
    }

    foreach (@sexpr) {
        s/ \n/ /go;
	s/\n/ /go;
	
	if ($remove_enumsent) {
	    if (/^[^%]*\\enumsentence/) {
		if (!(/\\enumsentence\{[^\\]*\\label/)) {
		    $exnum++;
		    s/\\enumsentence.*?{(.+)}/\\sitem{$1}\\label{ex:$exnum}/g;
		} else {
		    s/\\enumsentence.*?{(.+)}/\\sitem{$1}/g;
		}
	    }
	    if (/^[^%]*\\eenumsentence/) {
		if (!(/\\eenumsentence\{[^\\]*\\label/)) {
		    $exnum++;
		    s/\\eenumsentence.*?{(.+)}/\\sitem{$1}\\label{ex:$exnum}/g;
		} else {
		    s/\\eenumsentence.*?{(.+)}/\\sitem{$1}/g;
		}
	    }
	}

	if ($convert_psfig) {

	    if ($_ =~ /psfig{(.+?)}/) {
		$psargs = $1;
		$psfile = $1 if ($psargs =~ /=(.+?),/); 

		# $psfile =~ s#^ps#/mnt/linc/xtag/work/doc/tech-rept/ps# if !($psfile =~ m#^/#);
		# $psfile =~ s#^fig#/mnt/linc/xtag/work/doc/tech-rept/fig# if !($psfile =~ m#^/#);

		if ($psargs =~ /height=/) {
		    $height = $1 if ($psargs =~ /height=(.+)$/);
		    if ($height =~ /cm/) { $height = ((int(($` / 2.54) * 100) / 100)  . "in"); }
		    $newargs = "[height=$height]{$psfile}";
		}

		if ($psargs =~ /scale=/) {
		    $scale = $1 if ($psargs =~ /scale=(.+)$/);
		    $scale = $scale/100.0;
		    $newargs = "{$psfile}";	# ignore scale for the moment
		}

		$newargs = "{$psfile}";
		s/\\psfig{.+?}/\\includegraphics$newargs/;

	    }

	} else {

	    if ($_ =~ /psfig{(.+?)}/) {
		# s#figure=#figure=/mnt/linc/xtag/work/doc/tech-rept/# if !(m#figure=/#);
	    }

	}

	s#/mnt/linc/xtag/work/doc/tech-rept/##;


    }

    if ($remove_enumsent) {
	for ($x=0; $x < @sexpr; $x++) {
	    $refline = "";
	    while ($sexpr[$x] =~ /\\ex{(.+?)}/g) {
		$offset = 0;
		$refinc = ($1 > 0 ? 1 : -1);
		$refnum = ($1 > 0 ? abs($1) : ($1 == 0 ? 1 : abs($1) + 1)) ;
		$numex = 0;
		
		while ($numex < $refnum) {
		    $offset += $refinc;
		    $numex++ if (($refline = $sexpr[$x+$offset]) =~ /^[^%].+\\label{ex:(.+?)}/);
		}

		$reflabel = $1 if ($refline =~ /\\label{ex:(.+?)}/);
		$sexpr[$x] =~ s/\\ex{(.*?)}/\\ref{ex:$reflabel}/;
	    }
	}
    }

    $inblock = 0;
    foreach (@sexpr) 
    {
	if (($inblock == 0) && (/\\sitem/)) {
	    $inblock = 1;
	    print OUT "\\beginsentences\n";
	}
	elsif (($inblock == 1) && !(/^.?$/) && !(/\\sitem/)) {
	    $inblock = 0;
	    print OUT "\\endsentences\n\n";
	}
	elsif (($inblock == 1) && (/^[ \t]*$/)) {
	    $inblock = 0;
	    print OUT "\\endsentences\n\n";
	}
	print OUT "$_\n";
    }

    close IN;
    close OUT;
}
