#!/bin/bash

download_cmd="wget "

if [ ! -d ~/nltk_data/xtag_grammar ]; then
    mkdir -p ~/nltk_data/xtag_grammar
fi
cd ~/nltk_data/xtag_grammar
if ! type "wget" > /dev/null; then
 	if ! type "curl" > /dev/null; then
    	echo "Need wget or curl installed."
    	exit
	fi
fi
if type "curl" > /dev/null; then
	download_cmd="curl -LOk "
fi
if [ ! -d korean ]; then
	cmd=$download_cmd$"https://github.com/sfu-natlang/xtag-korean-grammar/archive/master.zip"
	eval $cmd
	unzip master 
	mv xtag-korean-grammar-master korean
	rm -f master.zip 
	
fi
if [  ! -d english ]; then
	cmd=$download_cmd$"https://github.com/sfu-natlang/xtag-english-grammar/archive/master.zip"
	eval $cmd
	unzip master 
	mv xtag-english-grammar-master english
	rm -f master.zip
fi

eval $download_cmd$"https://raw.github.com/sfu-natlang/xtag-nltk/master/util.py"
eval $download_cmd$"https://raw.github.com/sfu-natlang/xtag-nltk/master/load.py"
eval $download_cmd$"https://raw.github.com/sfu-natlang/xtag-nltk/master/feature.py"
eval $download_cmd$"https://raw.github.com/sfu-natlang/xtag-nltk/master/LL1.py"

python util.py
python -c'import util; util.install("english")'

rm -f *.{py,pyc}
