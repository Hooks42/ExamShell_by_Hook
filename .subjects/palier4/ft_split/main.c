#include <stdio.h>
#include <stdlib.h>
#include "ft_split.h"


void    ft_free(char **str)
{
    int i = 0;
    while (str[i])
    {
        free(str[i]);
        i++;
    }
    free(str[i]);
}

int main(void)
{
    char **str = ft_split("      \t\t\t\t\t\n\n\n    Hey comment ca va           pas  3892348382;'.;'. iiici ?    \n");
    int i = 0;
    while (str[i])
    {
        printf("%s\n", str[i]);
        i++;
    }
    ft_free(str);
}