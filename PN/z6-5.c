#include <stdio.h>
#include <stdlib.h>
#define OPERATIONS_NUMBER 3

double average(double *array, size_t n);
double max(double *array, size_t n);
double min(double *array, size_t n);

double (*operations[OPERATIONS_NUMBER])(double*, size_t) = {max, min, average};

int main(void) {
	printf("Podaj n: ");
	size_t n;
	scanf("%lu", &n);

	double *array = malloc(sizeof(double) * n);
	if (array == NULL) {
		// Czy ten przypadek jest na tyle realny
		// Że powinienem go obsługiwać?
		fprintf(stderr, "Nie udało się zaalokować pamięci!\n");
		return 255;
	}
	
	for (size_t i = 0; i < n; ++i) {
		printf("L.p. %lu: ", i + 1);
		scanf("%lf", &array[i]);
	}

	printf("Wybierz opcję: ");
	size_t choice;
	scanf("%lu", &choice);

	if (choice < OPERATIONS_NUMBER) {
		printf("Wynik: %lf\n", operations[choice](array, n));
	}

	free(array);
}

double average(double *array, size_t n) {
	double sum = 0;
	for (int i = 0; i < n; ++i) {
		sum += array[i];
	}

	return sum / n;
}

double max(double *array, size_t n) {
	double biggest = array[0];
	for (size_t i = 1; i < n; ++i) {
		if (array[i] > biggest) {
			biggest = array[i];
		}
	}

	return biggest;
}

double min(double *array, size_t n) {
	double smallest = array[0];
	for (size_t i = 1; i < n; ++i) {
		if (array[i] < smallest) {
			smallest = array[i];
		}
	}

	return smallest;
}

