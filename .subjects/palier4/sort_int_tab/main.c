#include <stdio.h>
#include "sort_int_tab.h"
#include <limits.h>

int main(void)
{
    int tab[5] = {81, 48, INT_MIN, INT_MAX, 0};
    int tab2[6] = {81, -48, INT_MIN, INT_MAX, 0, -3483};
    sort_int_tab(tab, 5);
    int i = 0;
    while (i < 5)
    {
        printf("%i\n", tab[i]);
        i++;
    }
    i = 0;
    sort_int_tab(tab2, 6);
    while (i < 6)
    {
        printf("%i\n", tab2[i]);
        i++;
    }
    return (0);
}