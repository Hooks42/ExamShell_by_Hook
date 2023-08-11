path_executable=".subjects/palier3/expand_str/argv_expand_str"
path_exo=".subjects/palier3/expand_str/expand_str.c"
path_trace=".subjects/palier3/expand_str/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="See? It's easy to print the same thing"
test2=" this        time it      will     be    more complex  . "
test3="   "
test4="a"
test5="  lorem,ipsum  "
test6="{}}{{||||{{||||||}}}} Hey c     ... comment ca va ? klwqklwlewklwlq 848348328238 {}}{{||||{{||||||}}}}"

timeout 3s $path_executable "$test1" | cat -e >> $path_trace

timeout 3s $path_executable "$test2" | cat -e >> $path_trace

timeout 3s $path_executable "$test3" | cat -e >> $path_trace

timeout 3s $path_executable "$test4" "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier3/expand_str/Correct_expand_str"
path_fichier="$HOME/Desktop/Exam/Rendu/expand_str/expand_str.c"
path_correct_trace=".subjects/palier3/expand_str/trace_exo.txt"
path_forbidden=".subjects/palier3/expand_str/forbidden.txt"
path_result_diff=".subjects/palier3/expand_str/result_diff.txt"
forbidden="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct "$test1" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test2" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test3" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test4" "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" | cat -e >> $path_correct_trace


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff

