path_executable=".subjects/palier3/str_capitalizer/argv_str_capitalizer"
path_exo=".subjects/palier3/str_capitalizer/str_capitalizer.c"
path_trace=".subjects/palier3/str_capitalizer/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="a FiRSt LiTTlE TESt"
test2="SecONd teST A LITtle BiT   Moar comPLEX"
test3="   But... This iS not THAT COMPLEX"
test4="     Okay, this is the last 1239809147801 but not    the least    t"
test5="{}}{{||||{{||||||}}}} Hey c     ... comment ca va ? klwqklwlewklwlq 848348328238 {}}{{||||{{||||||}}}}"
test6="           \t\n\rS kdskdsjkj 84384 8329 32..fd 838348 sdjsdkkasdj sda A/..,/ ./, /;l ;"

timeout 3s $path_executable "$test1" | cat -e >> $path_trace

timeout 3s $path_executable "$test2" | cat -e >> $path_trace

timeout 3s $path_executable "$test3" | cat -e >> $path_trace

timeout 3s $path_executable "$test4" "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test5" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" | cat -e >> $path_trace

timeout 3s $path_executable | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier3/str_capitalizer/Correct_str_capitalizer"
path_fichier="$HOME/Desktop/Exam/Rendu/str_capitalizer/str_capitalizer.c"
path_correct_trace=".subjects/palier3/str_capitalizer/trace_exo.txt"
path_forbidden=".subjects/palier3/str_capitalizer/forbidden.txt"
path_result_diff=".subjects/palier3/str_capitalizer/result_diff.txt"
forbidden="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct "$test1" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test2" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test3" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test4" "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" | cat -e >> $path_correct_trace

timeout 3s $path_correct | cat -e >> $path_correct_trace


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff

