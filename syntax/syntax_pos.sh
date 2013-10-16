#!/bin/bash
cat syntax-coded.flat | sed -e 's/^.*<<POS>>/<<POS>>/' | sed -e 's/<<POS>>//g' | tr '' '\n' | tr '<' ' ' | grep -v '^$' | awk '{print $1}' | sed -e 's/[1-9]$//' | sort | uniq -c | sort -nr
