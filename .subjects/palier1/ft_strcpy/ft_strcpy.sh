path_executable=".subjects/palier1/ft_strcpy/a.out"
path_main=".subjects/palier1/ft_strcpy/main.c"
path_exo=".subjects/palier1/ft_strcpy/ft_strcpy.c"


gcc -Wall -Wextra -Werror "$path_main" "$path_exo" -o "$path_executable"  

path_test=".subjects/palier1/ft_strcpy/a.out"
path_trace=".subjects/palier1/ft_strcpy/trace.txt"


timeout 3s $path_test | cat -e >> $path_trace


#===================================================================

path_correct=".subjects/palier1/ft_strcpy/Correct_ft_strcpy"
path_fichier="$HOME/Desktop/Exam/Rendu/ft_strcpy/ft_strcpy.c"
path_correct_trace=".subjects/palier1/ft_strcpy/trace_exo.txt"
path_forbidden=".subjects/palier1/ft_strcpy/forbidden.txt"

gcc -Wall -Wextra -Werror "$path_main" "$path_fichier" -o "$path_correct" 

timeout 3s $path_correct | cat -e >> $path_correct_trace


#=====================================================================

forbidden_lib="<stdio.h>\|<string.h>\|<stdlib.h>\|<string.h>\|<unistd.h>"
path_result_diff=".subjects/palier1/ft_strcpy/result_diff.txt"

cat $path_fichier | grep $forbidden_lib >> $path_forbidden

diff $path_trace $path_correct_trace >> $path_result_diff