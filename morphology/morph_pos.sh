cat trunc_morph.flat | cut -d' ' -f 2- | cut -b3- | tr '#' '\n' | awk '{print $2}' | sort | uniq -c | sort -nr
