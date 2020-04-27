#include <stdio.h>

int main(int argc, char *argv[]) {
	if (argc != 3) {
		fprintf(stderr, "Niepoprawne użycie programu\n");
		fprintf(stderr, "Użyj: %s <plik-wejsciowy> <plik-wyjsciowy>\n", argv[0]);
		return 1;
	}

	FILE *inputFile = fopen(argv[1], "r");
	if (inputFile == NULL) {
		fprintf(stderr, "Nie udało się załadować pliku wejściowego\n");
		return 2;
	}

	FILE *outputFile = fopen(argv[2], "w");
	if (outputFile == NULL) {
		fprintf(stderr, "Nie udało się załadować pliku wyjściowego\n");
		return 3;
	}

	int value;
	while (fscanf(inputFile, "%d", &value) == 1) {
		if (value > 137) {
			fprintf(outputFile, "%d\n", value);
		}
	}

	fclose(inputFile);
	fclose(outputFile);
	return 0;
}
