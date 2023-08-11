path_executable=".subjects/palier3/ft_range/a.out"
path_main=".subjects/palier3/ft_range/main.c"
path_exo=".subjects/palier3/ft_range/ft_range.c"


gcc -Wall -Wextra -Werror "$path_main" "$path_exo" -o "$path_executable"  

path_test=".subjects/palier3/ft_range/a.out"
path_trace=".subjects/palier3/ft_range/trace.txt"


timeout 3s $path_test | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier3/ft_range/Correct_ft_range"
path_fichier="$HOME/Desktop/Exam/Rendu/ft_range/ft_range.c"
path_correct_trace=".subjects/palier3/ft_range/trace_exo.txt"
path_forbidden=".subjects/palier3/ft_range/forbidden.txt"

gcc -Wall -Wextra -Werror "$path_main" "$path_fichier" -o "$path_correct" 

timeout 3s $path_correct | cat -e >> $path_correct_trace


#=====================================================================

forbidden_lib="<stdio.h>\|<string.h>\|<unistd.h>"
path_result_diff=".subjects/palier3/ft_range/result_diff.txt"

cat $path_fichier | grep $forbidden_lib >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff