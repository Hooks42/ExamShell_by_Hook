path_executable=".subjects/palier4/ft_itoa/a.out"
path_main=".subjects/palier4/ft_itoa/main.c"
path_exo=".subjects/palier4/ft_itoa/ft_itoa.c"


gcc -Wall -Wextra -Werror "$path_main" "$path_exo" -o "$path_executable"  

path_test=".subjects/palier4/ft_itoa/a.out"
path_trace=".subjects/palier4/ft_itoa/trace.txt"


timeout 3s $path_test | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier4/ft_itoa/Correct_ft_itoa"
path_fichier="$HOME/Desktop/Exam/Rendu/ft_itoa/ft_itoa.c"
path_correct_trace=".subjects/palier4/ft_itoa/trace_exo.txt"
path_forbidden=".subjects/palier4/ft_itoa/forbidden.txt"

gcc -Wall -Wextra -Werror "$path_main" "$path_fichier" -o "$path_correct" 

timeout 3s $path_correct | cat -e >> $path_correct_trace


#=====================================================================

forbidden_lib="<stdio.h>\|<string.h>\|<unistd.h>"
path_result_diff=".subjects/palier4/ft_itoa/result_diff.txt"

cat $path_fichier | grep $forbidden_lib >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff