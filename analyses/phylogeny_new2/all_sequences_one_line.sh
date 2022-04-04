awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < $1 > sliding_windows_leopards_one_line.fa
