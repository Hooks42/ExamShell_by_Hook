path_executable=".subjects/palier3/hidenp/argv_hidenp"
path_exo=".subjects/palier3/hidenp/hidenp.c"
path_trace=".subjects/palier3/hidenp/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="fgex.;"
test2="tyf34gdgf;'ektufjhgdgex.;.;rtjynur6"
test3="abc"
test3b="2altrb53c.sse"
test4="abc"
test5="btarc"
test6="{}}{{||||{{||||||}}}} Hey c     ... comment ca va ? klwqklwlewklwlq 848348328238 {}}{{||||{{||||||}}}}"
test7="{}jdksiojhd ewqwewu iew uquew73479328239080e08eff d09320- 3?"

timeout 3s $path_executable "$test1" "$test2"| cat -e >> $path_trace

timeout 3s $path_executable "$test3" "$test3b" | cat -e >> $path_trace

timeout 3s $path_executable "$test4" "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" "$test7" | cat -e >> $path_trace

timeout 3s $path_executable "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" "$test1" "$test3" | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier3/hidenp/Correct_hidenp"
path_fichier="$HOME/Desktop/Exam/Rendu/hidenp/hidenp.c"
path_correct_trace=".subjects/palier3/hidenp/trace_exo.txt"
path_forbidden=".subjects/palier3/hidenp/forbidden.txt"
path_result_diff=".subjects/palier3/hidenp/result_diff.txt"
forbidden="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct "$test1" "$test2"| cat -e >> $path_correct_trace

timeout 3s $path_correct "$test3" "$test3b" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test4" "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" "$test7" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" "$test1" "$test3" | cat -e >> $path_correct_trace


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff

