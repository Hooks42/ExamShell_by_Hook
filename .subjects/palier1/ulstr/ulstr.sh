path_executable=".subjects/palier1/ulstr/argv_ulstr"
path_exo=".subjects/palier1/ulstr/ulstr.c"
path_trace=".subjects/palier1/ulstr/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="L'eSPrit nE peUt plUs pRogResSer s'Il staGne et sI peRsIsTent VAnIte et auto-justification."
test2="S'enTOuRer dE sECreT eSt uN sIGnE De mAnQuE De coNNaiSSanCe.  "
test3="3:21 Ba  tOut  moUn ki Ka di KE m'en Ka fe fot"
test5="  lorem,ipsum  "
test6="{}}{{||||{{||||||}}}} Hey c     ... comment ca va ? klwqklwlewklwlq 848348328238 {}}{{||||{{||||||}}}}"

timeout 3s $path_executable "$test1" | cat -e >> $path_trace

timeout 3s $path_executable "$test2" | cat -e >> $path_trace

timeout 3s $path_executable "$test3" | cat -e >> $path_trace

timeout 3s $path_executable | cat -e >> $path_trace

timeout 3s $path_executable "$test5" "$test6" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier1/ulstr/Correct_ulstr"
path_fichier="$HOME/Desktop/Exam/Rendu/ulstr/ulstr.c"
path_correct_trace=".subjects/palier1/ulstr/trace_exo.txt"
path_forbidden=".subjects/palier1/ulstr/forbidden.txt"
path_result_diff=".subjects/palier1/ulstr/result_diff.txt"
forbidden="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct "$test1" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test2" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test3" | cat -e >> $path_correct_trace

timeout 3s $path_correct | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" "$test6" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" | cat -e >> $path_correct_trace


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff