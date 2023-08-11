#include "ft_range.h"
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main(void)
{
    int *tab = ft_range(1, 434);
    int i = 0;
    while (i < 434)
    {
        printf("%i\t", tab[i]);
        i++;
    }
    free(tab);
    i = 0;
    tab = ft_range(434, -1);
    while (i < 434)
    {
        printf("%i\t", tab[i]);
        i++;
    }
    free(tab);
    i = 0;
    tab = ft_range(434, 434);
    while (i < 1)
    {
        printf("%i\t", tab[i]);
        i++;
    }
    free(tab);
    return (0);
}