path_executable=".subjects/palier2/wdmatch/argv_wdmatch"
path_exo=".subjects/palier2/wdmatch/wdmatch.c"
path_trace=".subjects/palier2/wdmatch/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="faya"
test2="fgvvfdxcacpolhyghbreda"
test3="faya"
test3b="fgvvfdxcacpolhyghbred"
test4="forty two"
test5="qfqfsoudf arzgrsayns tsryegftdgs sjytwdekuooixq "
test6="{}}{{||||{{||||||}}}} Hey c     ... comment ca va ? klwqklwlewklwlq 848348328238 {}}{{||||{{||||||}}}}"
test7="{}jdksiojhd ewqwewu iew uquew73479328239080e08eff d09320- 3?"

timeout 3s $path_executable "$test1" "$test2"| cat -e >> $path_trace

timeout 3s $path_executable "$test3" "$test3b" | cat -e >> $path_trace

timeout 3s $path_executable "$test4" "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" "$test7" | cat -e >> $path_trace

timeout 3s $path_executable "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" "$test1" "$test3" | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier2/wdmatch/Correct_wdmatch"
path_fichier="$HOME/Desktop/Exam/Rendu/wdmatch/wdmatch.c"
path_correct_trace=".subjects/palier2/wdmatch/trace_exo.txt"
path_forbidden=".subjects/palier2/wdmatch/forbidden.txt"
path_result_diff=".subjects/palier2/wdmatch/result_diff.txt"
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

