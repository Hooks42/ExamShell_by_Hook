path_executable=".subjects/palier2/snake_to_camel/argv_snake_to_camel"
path_exo=".subjects/palier2/snake_to_camel/snake_to_camel.c"
path_trace=".subjects/palier2/snake_to_camel/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="here_is_a_snake_case_word"
test2="helloWorld"
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

path_correct=".subjects/palier2/snake_to_camel/Correct_snake_to_camel"
path_fichier="$HOME/Desktop/Exam/Rendu/snake_to_camel/snake_to_camel.c"
path_correct_trace=".subjects/palier2/snake_to_camel/trace_exo.txt"
path_forbidden=".subjects/palier2/snake_to_camel/forbidden.txt"
path_result_diff=".subjects/palier2/snake_to_camel/result_diff.txt"
forbidden="<stdio.h>\|<string.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct "$test1" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test2" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test3" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test4" "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" | cat -e >> $path_correct_trace


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

cat $path_fichier | grep "atoi" >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff

