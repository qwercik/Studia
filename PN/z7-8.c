#include <stdio.h>
#include <stdbool.h>
#define MEASUREMENT_VALUES_NUMBER 4

double average(double values[], int n);
double min(double values[], int n);
double max(double values[], int n);

double (*valueProcessors[])(double[], int) = {average, min, max};

typedef struct {
	int id;
	double values[MEASUREMENT_VALUES_NUMBER];
	double result;
	int code;
} Measurement;

double average(double values[], int n) {
	double sum = 0;
	for (int i = 0; i < n; ++i) {
		sum += values[i];
	}

	return sum / n;
}

double min(double values[], int n) {
	int value = values[0];
	for (int i = 1; i < n; ++i) {
		if (values[i] < value) {
			value = values[i];
		}
	}

	return value;
}

double max(double values[], int n) {
	int value = values[0];
	for (int i = 1; i < n; ++i) {
		if (values[i] > value) {
			value = values[i];
		}
	}

	return value;
}

int main(void) {
	const char *inputFilename = "Pomiary.txt";
	FILE *file = fopen(inputFilename, "r");
	if (file == NULL) {
		fprintf(stderr, "Nie udało się załadować pliku\n");
		return 1;
	}

	const char *outputFilename = "Wyniki.txt";
	FILE *outputFile = fopen(outputFilename, "w");
	if (outputFile == NULL) {
		fprintf(stderr, "Nie udało się otworzyć pliku do zapisu\n");
		return 2;
	}

	while (!feof(file)) {
		Measurement measurement;
		if (fscanf(file, "%d", &measurement.id) != 1) {
			break;
		}

		bool error = false;
		for (int i = 0; i < MEASUREMENT_VALUES_NUMBER; ++i) {
			if (fscanf(file, "%lf", &measurement.values[i]) != 1) {
				error = true;
				break;
			}
		}
		if (error) {
			break;
		}

		if (fscanf(file, "%d", &measurement.code) != 1) {
			break;
		}

		// Jeżeli kod dotarł do tego momentu, to znaczy że measurement jest ok
		if (measurement.code < 0 || measurement.code > 2) {
			fprintf(stderr, "Niepoprawny kod\n");
			break;
		} else {
			measurement.result = valueProcessors[measurement.code](measurement.values, MEASUREMENT_VALUES_NUMBER);
		}

		fprintf(outputFile, "%d %lf %d\n", measurement.id, measurement.result, measurement.code);
	}

	return 0;
}
