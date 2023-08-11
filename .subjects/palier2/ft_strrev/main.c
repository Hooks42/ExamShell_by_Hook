#include "ft_strrev.h"
#include <stdio.h>

int main(void)
{
    printf("%s\n", ft_strrev("Ceci est un test\n"));
    printf("%s\n", ft_strrev("dhdjdshjs37737393893/,',',';,/.,./][][]{}{{}}{\t\r\v\n"));
    printf("%s\n", ft_strrev("\0"));
    return (0);
}