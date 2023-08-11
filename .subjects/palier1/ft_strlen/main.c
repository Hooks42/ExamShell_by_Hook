#include <stdio.h>
#include "ft_strlen.h"

int main(void)
{
	char str[] = "0123456789";
	char str1[] = "test";

	printf("10:%d\n", ft_strlen(str));
	printf("4:%d\n", ft_strlen(str1));
}