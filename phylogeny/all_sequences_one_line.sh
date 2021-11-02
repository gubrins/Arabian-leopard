awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < all.sequences.fa > good_all_sequences.fa
