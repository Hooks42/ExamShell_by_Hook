#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include "ft_itoa.h"

int main(void)
{
    char *str;
    str = ft_itoa(INT_MIN);
    printf("%s\n", str);
    //free(str);
    str = ft_itoa(INT_MAX);
    printf("%s\n", str);
    free(str);
    str = ft_itoa(0);
    printf("%s\n", str);
    //free(str);
    str = ft_itoa(-372);
    printf("%s\n", str);
    free(str);
    str = ft_itoa(372);
    printf("%s\n", str);
    free(str);
    return (0);
}