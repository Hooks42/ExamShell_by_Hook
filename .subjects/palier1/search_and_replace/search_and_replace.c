#include <unistd.h>

int ft_is_letter(char c)
{
    if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
        return (1);
    else
        return (0);
}

int main(int argc, char **argv)
{
    int i = 0;

    if (argc == 4 && !argv[2][1] & !argv[3][1])
    {
        while (argv[1][i]!='\0')
        {
            if (argv[1][i] == argv[2][0] && ft_is_letter(argv[1][i]) && ft_is_letter(argv[2][0]))
            {
                argv[1][i] = argv[3][0];
            }
            write (1, &argv[1][i], 1);
            i++;
        }
    }
    write (1, "\n", 1);
}
