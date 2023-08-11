path_executable=".subjects/palier2/max/a.out"
path_main=".subjects/palier2/max/main.c"
path_exo=".subjects/palier2/max/max.c"


gcc -Wall -Wextra -Werror "$path_main" "$path_exo" -o "$path_executable"  

path_test=".subjects/palier2/max/a.out"
path_trace=".subjects/palier2/max/trace.txt"


timeout 3s $path_test | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier2/max/Correct_max"
path_fichier="$HOME/Desktop/Exam/Rendu/max/max.c"
path_correct_trace=".subjects/palier2/max/trace_exo.txt"
path_forbidden=".subjects/palier2/max/forbidden.txt"

gcc -Wall -Wextra -Werror "$path_main" "$path_fichier" -o "$path_correct" 

timeout 3s $path_correct | cat -e >> $path_correct_trace


#=====================================================================

forbidden_lib="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>\|<unistd.h>"
path_result_diff=".subjects/palier2/max/result_diff.txt"

cat $path_fichier | grep $forbidden_lib >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff