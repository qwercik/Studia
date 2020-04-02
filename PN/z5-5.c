#include <stdio.h>
#include <stdlib.h>

int main(void) {
	int x, n, m;
	int **tablica;
	int i, j;

	printf("Podaj X: ");
	scanf("%d", &x);

	printf("Podaj n: ");
	scanf("%d", &n);

	printf("Podaj m: ");
	scanf("%d", &m);

	tablica = malloc(n * sizeof(int *));
	for (i = 0; i < n; ++i) {
		tablica[i] = malloc(m * sizeof(int));

		printf("Wypełniasz wiersz nr %d:\n", i + 1);
		for (j = 0; j < m; ++j) {
			printf("\tPodaj kolumnę nr %d: ", j + 1);
			scanf("%d", tablica[i] + j);
		}
	}

	int ile = 0;
	for (int i = 0; i < m; ++i) {
		int s = 0;
		for (int j = 0; j < n; ++j) {
			s += tablica[j][i];
		}

		if (s > x) {
			ile++;
		}
	}
	
	printf("%d kolumn posiada sumę większą, niż %d", ile, x);
	return 0;
}
