#include "ft_strcpy.h"
#include <stdio.h>

int main(void)
{
	char dest[] = "hey rogeweeer";
	char src[] = "Success";
	printf("%s\n", ft_strcpy(dest, src));
	char src2[] = "";
	printf("%s\n", ft_strcpy(dest, src2));
}