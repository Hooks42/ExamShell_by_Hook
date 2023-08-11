path_executable=".subjects/palier2/ft_strrev/a.out"
path_main=".subjects/palier2/ft_strrev/main.c"
path_exo=".subjects/palier2/ft_strrev/ft_strrev.c"


gcc -Wall -Wextra -Werror "$path_main" "$path_exo" -o "$path_executable"  

path_test=".subjects/palier2/ft_strrev/a.out"
path_trace=".subjects/palier2/ft_strrev/trace.txt"


timeout 3s $path_test | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier2/ft_strrev/Correct_ft_strrev"
path_fichier="$HOME/Desktop/Exam/Rendu/ft_strrev/ft_strrev.c"
path_correct_trace=".subjects/palier2/ft_strrev/trace_exo.txt"
path_forbidden=".subjects/palier2/ft_strrev/forbidden.txt"

gcc -Wall -Wextra -Werror "$path_main" "$path_fichier" -o "$path_correct" 

timeout 3s $path_correct | cat -e >> $path_correct_trace


#=====================================================================

forbidden_lib="<stdio.h>\|<string.h>\|<stdlib.h>\|<unistd.h>"
path_result_diff=".subjects/palier2/ft_strrev/result_diff.txt"

cat $path_fichier | grep $forbidden_lib >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff