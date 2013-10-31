xtag-english-grammar
====================

The XTAG English Grammar mirrored from the XTAG page http://www.cis.upenn.edu/~xtag/

<pre>
Begin
Title:          XTAG English Grammar
Version:        5.46
Entered-date:   24 February 2001
Description:    A wide-coverage lexicalized Tree Adjoining Grammar for English
Keywords:       TAG XTAG NLP
Author:         XTAG Group <xtag-dev@linc.cis.upenn.edu>
Maintained-by:  XTAG Group <xtag-bugs@linc.cis.upenn.edu>
Home-page:      http://www.cis.upenn.edu/~xtag/
Alternate-site:
Primary-site:   ftp://ftp.cis.upenn.edu/pub/xtag/release-2.24.2001/
Platform:       Data can be read on any platform. Viewer requires Tcl/Tk.
Copying-policy: GPL
End             
</pre>


Install instructions:
--------------------

Execute the following commands:

On Linux/Mac OS
<pre>
curl -O https://raw.github.com/sfu-natlang/xtag-english-grammar/master/install.sh
bash install.sh
</pre>

Or
<pre>
wget https://raw.github.com/sfu-natlang/xtag-english-grammar/master/install.sh
bash install.sh
</pre>

Edit the INSTALL script to reflect the location of perl in
your system.

Run INSTALL in the english directory with the full path of the
directory you have installed the english grammar. For example,

<pre>
% csh INSTALL /mnt/linc/home/anoop/english/
</pre>

The last / in the directory name is important and should not
be omitted.

