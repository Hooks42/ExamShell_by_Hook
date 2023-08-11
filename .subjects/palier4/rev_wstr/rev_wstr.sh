path_executable=".subjects/palier4/rev_wstr/argv_rev_wstr"
path_exo=".subjects/palier4/rev_wstr/rev_wstr.c"
path_trace=".subjects/palier4/rev_wstr/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="You hate people! But I love gatherings. Isn't it ironic?"
test2="abcdefghijklm"
test3="Wingardium Leviosa"
test4=" ajsdh . sisidj 3838398 ';[ hey   /  "
test5=" lorem,ipsum  "
test6=" {}}{{||||{{||||||}}}} Hey c     ... comment ca va ? klwqklwlewklwlq 848348328238 {}}{{||||{{||||||}}}}  "

timeout 3s $path_executable | cat -e >> $path_trace

timeout 3s $path_executable "$test1" | cat -e >> $path_trace

timeout 3s $path_executable "$test2" | cat -e >> $path_trace

timeout 3s $path_executable "$test3" | cat -e >> $path_trace

timeout 3s $path_executable "$test4" "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier4/rev_wstr/Correct_rev_wstr"
path_fichier="$HOME/Desktop/Exam/Rendu/rev_wstr/rev_wstr.c"
path_correct_trace=".subjects/palier4/rev_wstr/trace_exo.txt"
path_forbidden=".subjects/palier4/rev_wstr/forbidden.txt"
path_result_diff=".subjects/palier4/rev_wstr/result_diff.txt"
forbidden="<stdio.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test1" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test2" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test3" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test4" "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" | cat -e >> $path_correct_trace


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff

