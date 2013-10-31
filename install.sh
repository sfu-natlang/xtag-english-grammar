if [ ! -d ~/nltk_data/xtag_grammar ]; then
    mkdir -p ~/nltk_data/xtag_grammar
fi
cd ~/nltk_data/xtag_grammar
if [ ! -d korean ]; then
	curl -LOk https://github.com/sfu-natlang/xtag-korean-grammar/archive/master.zip
	unzip master 
	mv xtag-korean-grammar-master korean
	rm -f master.zip 
fi
if [  ! -d english ]; then
	curl -LOk https://github.com/sfu-natlang/xtag-english-grammar/archive/master.zip 
	unzip master 
	mv xtag-english-grammar-master english
	:rm -f master.zip
fi
curl -O https://raw.github.com/sfu-natlang/xtag-nltk/master/util.py
curl -O https://raw.github.com/sfu-natlang/xtag-nltk/master/load.py
curl -O https://raw.github.com/sfu-natlang/xtag-nltk/master/feature.py

python util.py
rm -f *.{py,pyc}
