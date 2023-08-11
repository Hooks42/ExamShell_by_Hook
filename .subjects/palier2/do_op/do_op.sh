path_executable=".subjects/palier2/do_op/argv_do_op"
path_exo=".subjects/palier2/do_op/do_op.c"
path_trace=".subjects/palier2/do_op/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

timeout 3s $path_executable "123" "+" "456" | cat -e >> $path_trace

timeout 3s $path_executable "9828" "/" "234" | cat -e >> $path_trace

timeout 3s $path_executable "1" "+" "-43" | cat -e >> $path_trace

timeout 3s $path_executable "34" "-" "214" | cat -e >> $path_trace

timeout 3s $path_executable "27" "%" "5" | cat -e >> $path_trace

timeout 3s $path_executable "120" "/" "0" | cat -e >> $path_trace

timeout 3s $path_executable "27" "%" "5" "7" | cat -e >> $path_trace

timeout 3s $path_executable "27" "%" "5" "327" | cat -e >> $path_trace

timeout 3s $path_executable | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier2/do_op/Correct_do_op"
path_fichier="$HOME/Desktop/Exam/Rendu/do_op/do_op.c"
path_correct_trace=".subjects/palier2/do_op/trace_exo.txt"
path_forbidden=".subjects/palier2/do_op/forbidden.txt"
path_result_diff=".subjects/palier2/do_op/result_diff.txt"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct "123" "+" "456" | cat -e >> $path_correct_trace

timeout 3s $path_correct "9828" "/" "234" | cat -e >> $path_correct_trace

timeout 3s $path_correct "1" "+" "-43" | cat -e >> $path_correct_trace

timeout 3s $path_correct "34" "-" "214" | cat -e >> $path_correct_trace

timeout 3s $path_correct "27" "%" "5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "27" "%" "5" "7" | cat -e >> $path_correct_trace

timeout 3s $path_correct "27" "%" "5" "327" | cat -e >> $path_correct_trace

timeout 3s $path_correct | cat -e >> $path_correct_trace

#=====================================================================

cat $path_fichier | grep "malloc\|free\|realloc\|calloc" >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff

