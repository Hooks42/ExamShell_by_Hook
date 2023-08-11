#include "ft_rrange.h"
#include <stdio.h>
#include "ft_rrange.h"
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>

int main(void)
{
    int *tab = ft_rrange(1, 434);
    int i = 0;
    while (i < 435)
    {
        printf("%i\t", tab[i]);
        i++;
    }
    free(tab);
    i = 0;
    tab = ft_rrange(434, -1);
    while (i < 435)
    {
        printf("%i\t", tab[i]);
        i++;
    }
    free(tab);
    i = 0;
    tab = ft_rrange(434, 434);
    while (i < 1)
    {
        printf("%i\t", tab[i]);
        i++;
    }
    free(tab);
    return (0);
}