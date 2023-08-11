#include "max.h"
#include <stdio.h>
#include <limits.h>

int main(void)
{
    int tab[5] = {INT_MIN, INT_MAX, 0, -283, 3822};
    int tab2[5] = {-245, -245, -245, -245, -245};
    int tab3[5] = {-245, -6556, -345 -235, -677};
    printf("%i\n", max(tab, 5));
    printf("%i\n", max(tab2, 5));
    printf("%i\n", max(tab3, 5));
    return (0);
}