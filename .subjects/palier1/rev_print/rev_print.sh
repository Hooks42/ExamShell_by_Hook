path_executable=".subjects/palier1/rev_print/argv_rev_print"
path_exo=".subjects/palier1/rev_print/rev_print.c"
path_trace=".subjects/palier1/rev_print/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="zaz"
test2="dub0 a POIL"
test3="   "
test4=""
test5="  lorem,ipsum  "
test6="{}}{{||||{{||||||}}}} Hey c     ... comment ca va ? klwqklwlewklwlq 848348328238 {}}{{||||{{||||||}}}}"

timeout 3s $path_executable "$test1" | cat -e >> $path_trace

timeout 3s $path_executable "$test2" | cat -e >> $path_trace

timeout 3s $path_executable "$test3" | cat -e >> $path_trace

timeout 3s $path_executable "$test4" | cat -e >> $path_trace

timeout 3s $path_executable "$test5" "$test6" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier1/rev_print/Correct_rev_print"
path_fichier="$HOME/Desktop/Exam/Rendu/rev_print/rev_print.c"
path_correct_trace=".subjects/palier1/rev_print/trace_exo.txt"
path_forbidden=".subjects/palier1/rev_print/forbidden.txt"
path_result_diff=".subjects/palier1/rev_print/result_diff.txt"
forbidden="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct "$test1" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test2" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test3" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test4" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" "$test6" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" | cat -e >> $path_correct_trace


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff