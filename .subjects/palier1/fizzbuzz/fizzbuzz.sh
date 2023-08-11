path_executable=".subjects/palier1/fizzbuzz/main"
path_exo=".subjects/palier1/fizzbuzz/fizzbuzz.c"
path_trace=".subjects/palier1/fizzbuzz/trace.txt"

gcc -Wall -Wextra -Werror "$path_exo" -o "$path_executable"

timeout 3s $path_executable | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier1/fizzbuzz/Correct_fizzbuzz"
path_fichier="$HOME/Desktop/Exam/Rendu/fizzbuzz/fizzbuzz.c"
path_correct_trace=".subjects/palier1/fizzbuzz/trace_exo.txt"
path_forbidden=".subjects/palier1/fizzbuzz/forbidden.txt"
path_result_diff=".subjects/palier1/fizzbuzz/result_diff.txt"
forbidden="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct | cat -e >> $path_correct_trace


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff