path_executable=".subjects/palier1/search_and_replace/argv_search_and_replace"
path_exo=".subjects/palier1/search_and_replace/search_and_replace.c"
path_trace=".subjects/palier1/search_and_replace/trace.txt"

gcc -Wall -Wextra -Werror $path_exo -o $path_executable


#===================================================================

test1="Papache est un sabre"
test2="zaz"
test4="ZoZ eT Dovid oiME le METol."
test5="wNcOre Un ExEmPle Pas Facilw a Ecrirw"
test6="{}}{{||||{{||||||}}}} Hey c     ... comment ca va ? klwqklwlewklwlq 848348328238 {}}{{||||{{||||||}}}}"

timeout 3s $path_executable "$test1" "a" "o" | cat -e >> $path_trace

timeout 3s $path_executable "$test2" "art" "zul" | cat -e >> $path_trace

timeout 3s $path_executable "$test2" "r" "u" | cat -e >> $path_trace

timeout 3s $path_executable "$test1" "a" "b" "c" "d" "e" "f" | cat -e >> $path_trace

timeout 3s $path_executable "$test4" "o" "a" | cat -e >> $path_trace

timeout 3s $path_executable "$test5" "w" "e" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" "{" "!" | cat -e >> $path_trace

timeout 3s $path_executable "$test6" "8" "1" | cat -e >> $path_trace 


#===================================================================

path_correct=".subjects/palier1/search_and_replace/Correct_search_and_replace"
path_fichier="$HOME/Desktop/Exam/Rendu/search_and_replace/search_and_replace.c"
path_correct_trace=".subjects/palier1/search_and_replace/trace_exo.txt"
path_forbidden=".subjects/palier1/search_and_replace/forbidden.txt"
path_result_diff=".subjects/palier1/search_and_replace/result_diff.txt"
forbidden="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>"

gcc -Wall -Wextra -Werror "$path_fichier" -o "$path_correct"

timeout 3s $path_correct "$test1" "a" "o" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test2" "art" "zul" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test2" "r" "u" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test1" "a" "b" "c" "d" "e" "f" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test4" "o" "a" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test5" "w" "e" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" "{" "!" | cat -e >> $path_correct_trace

timeout 3s $path_correct "$test6" "8" "1" | cat -e >> $path_correct_trace 


#=====================================================================

cat $path_fichier | grep $forbidden >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff