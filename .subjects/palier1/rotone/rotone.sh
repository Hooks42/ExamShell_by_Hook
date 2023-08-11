path_executable=".subjects/palier1/rotone/argv_rotone"
path_exo=".subjects/palier1/rotone/rotone.c"
path_trace=".subjects/palier1/rotone/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="abc"
test2="Les stagiaires du staff ne sentent pas toujours tres bon."
test3="AkjhZ zLKIJz , 23y "
test5=""
test6="{}}{{||||{{||||||}}}} Hey c     ... comment ca va ? klwqklwlewklwlq 848348328238 {}}{{||||{{||||||}}}}"

timeout 3s $path_executable "$test1" | cat -e >> $path_trace

timeout 3s $path_executable "$test2" | cat -e >> $path_trace

timeout 3s $path_executable "$test3" | cat -e >> $path_trace

timeout 3s $path_executable  | cat -e >> $path_trace

timeout 3s $path_executable "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test5" "$test6" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier1/rotone/Correct_rotone"
path_fichier="$HOME/Desktop/Exam/Rendu/rotone/rotone.c"
path_correct_trace=".subjects/palier1/rotone/trace_exo.txt"
path_forbidden=".subjects/palier1/rotone/forbidden.txt"
path_result_diff=".subjects/palier1/rotone/result_diff.txt"
forbidden="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct "$test1" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test2" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test3" | cat -e >> $path_correct_trace

timeout 3s $path_correct  | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" "$test6" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" | cat -e >> $path_correct_trace


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff