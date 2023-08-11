path_executable=".subjects/palier2/inter/argv_inter"
path_exo=".subjects/palier2/inter/inter.c"
path_trace=".subjects/palier2/inter/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="padinton"
test2="paqefwtdjetyiytjneytjoeyjnejeyj"
test3="ddf6vewg64f"
test3b="gtwthgdwthdwfteewhrtag6h4ffdhsd"
test4="rien"
test5="cette phrase ne cache rien"
test6="{}}{{||||{{||||||}}}} Hey c     ... comment ca va ? klwqklwlewklwlq 848348328238 {}}{{||||{{||||||}}}}"
test7="{}jdksiojhd ewqwewu iew uquew73479328239080e08eff d09320- 3?"

timeout 3s $path_executable "$test1" "$test2"| cat -e >> $path_trace

timeout 3s $path_executable "$test3" "$test3b" | cat -e >> $path_trace

timeout 3s $path_executable "$test4" "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" "$test7" | cat -e >> $path_trace

timeout 3s $path_executable "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" "$test1" "$test3" | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier2/inter/Correct_inter"
path_fichier="$HOME/Desktop/Exam/Rendu/inter/inter.c"
path_correct_trace=".subjects/palier2/inter/trace_exo.txt"
path_forbidden=".subjects/palier2/inter/forbidden.txt"
path_result_diff=".subjects/palier2/inter/result_diff.txt"
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

