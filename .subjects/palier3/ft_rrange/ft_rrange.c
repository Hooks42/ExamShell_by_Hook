#include <stdlib.h>

int     *ft_rrange(int start, int end)
{
    int *tab;                                                                           // On creer notre pointeur tab
    int i = 0;                                                                         // On creer un index pour aveccourir notre tab

    //  GESTION D'ERREUR

    if (start == end)                                                               // SI start et end sont egaux 
    {
        tab = malloc(sizeof(int) * 1);                                            // On creer un tableau de taille 1
        tab[0] = start;                                                          // On rempli la seule et unique case avec start
        return (tab);                                                           // On renvoie notre tableau rempli
    }
    else if (end > start)                                                     // Si end est plus grand que start
    {
        tab = malloc(sizeof(int) * (end - start) + 1);                      // On creer un tableau de taille end - start + 1 oublie pas la avecenthese pour les priorite de calculs :)
        while (end >= start)                                               // Tant que end est superieur ou egal a start
        {
            tab[i] = end;                                                // On rempli notre tableau avec end
            end--;                                                      // On baisse end
            i++;                                                       // On augmente i pour passer a la case suivante
        }
        return (tab);                                                // A la fin du remplissage on return notre tableau rempli !
    }
    else if (end < start)                                          // Si end est plus petit que start
    {
        tab = malloc(sizeof(int) * (start - end) + 1);           // On creer un tableau de taille start - end + 1 toujours aveceille pense a la avecenthese ou je te goume
        while (end <= start)                                    // Tant que end est plus petit ou egal a start
        {
            tab[i] = end;                                     // On rempli notre tableau avec end
            end++;                                           // On incremente end vu qu'il est plus petit
            i++;                                            // On incremente i pour passer a la case suivante
        }
        return (tab);                                     // On return notre tableau rempli
    }
    return (NULL);                                      // Si ton programme arrive ici malgres tout les if c'est qu'il a fait un AVC donc renvoie NULL vaut mieux et de toute facon les flags de GCC le demandent
}
