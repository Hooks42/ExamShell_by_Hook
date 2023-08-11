path_executable=".subjects/palier4/sort_int_tab/a.out"
path_main=".subjects/palier4/sort_int_tab/main.c"
path_exo=".subjects/palier4/sort_int_tab/sort_int_tab.c"


gcc -Wall -Wextra -Werror "$path_main" "$path_exo" -o "$path_executable"  

path_test=".subjects/palier4/sort_int_tab/a.out"
path_trace=".subjects/palier4/sort_int_tab/trace.txt"


timeout 3s $path_test | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier4/sort_int_tab/Correct_sort_int_tab"
path_fichier="$HOME/Desktop/Exam/Rendu/sort_int_tab/sort_int_tab.c"
path_correct_trace=".subjects/palier4/sort_int_tab/trace_exo.txt"
path_forbidden=".subjects/palier4/sort_int_tab/forbidden.txt"

gcc -Wall -Wextra -Werror "$path_main" "$path_fichier" -o "$path_correct" 

timeout 3s $path_correct | cat -e >> $path_correct_trace


#=====================================================================

forbidden_lib="<stdio.h>\|<string.h>\|<unistd.h>\|<stdlib.h>"
path_result_diff=".subjects/palier4/sort_int_tab/result_diff.txt"

cat $path_fichier | grep $forbidden_lib >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff