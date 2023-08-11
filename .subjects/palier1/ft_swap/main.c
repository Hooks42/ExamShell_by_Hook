#include "ft_swap.h"
#include <unistd.h>
#include <stdio.h>

int main(void)
{
	int a = 3;
	int b = 18;
	ft_swap(&a, &b);
	if (b == 3 && a == 18)
	{
		write(1, "OK\n", 3);
	}
	else
	{
		write(1, "FAIL\n", 5);
	}
}