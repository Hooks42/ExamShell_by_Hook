path_executable=".subjects/palier3/tab_mult/argv_tab_mult"
path_exo=".subjects/palier3/tab_mult/tab_mult.c"
path_trace=".subjects/palier3/tab_mult/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="212"
test2="57"
test3="21"
test4="-21"
test5="0"
test6="-13"

timeout 3s $path_executable "$test1" | cat -e >> $path_trace

timeout 3s $path_executable "$test2" | cat -e >> $path_trace

timeout 3s $path_executable "$test3" | cat -e >> $path_trace

timeout 3s $path_executable "$test4" "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" | cat -e >> $path_trace

timeout 3s $path_executable | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier3/tab_mult/Correct_tab_mult"
path_fichier="$HOME/Desktop/Exam/Rendu/tab_mult/tab_mult.c"
path_correct_trace=".subjects/palier3/tab_mult/trace_exo.txt"
path_forbidden=".subjects/palier3/tab_mult/forbidden.txt"
path_result_diff=".subjects/palier3/tab_mult/result_diff.txt"
forbidden="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct "$test1" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test2" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test3" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test4" "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" | cat -e >> $path_correct_trace

timeout 3s $path_correct | cat -e >> $path_correct_trace


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff

