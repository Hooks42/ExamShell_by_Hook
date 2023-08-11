path_executable=".subjects/palier2/camel_to_snake/argv_camel_to_snake"
path_exo=".subjects/palier2/camel_to_snake/camel_to_snake.c"
path_trace=".subjects/palier2/camel_to_snake/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="hereIsACamelCaseWord"
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

path_correct=".subjects/palier2/camel_to_snake/Correct_camel_to_snake"
path_fichier="$HOME/Desktop/Exam/Rendu/camel_to_snake/camel_to_snake.c"
path_correct_trace=".subjects/palier2/camel_to_snake/trace_exo.txt"
path_forbidden=".subjects/palier2/camel_to_snake/forbidden.txt"
path_result_diff=".subjects/palier2/camel_to_snake/result_diff.txt"
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

