// To mini wariacja tego zadania
// Wczytywanie pliku o określonej na sztywno nazwie jest wg mnie głupie
// Dlatego nazwę podaję jako argument i odczytuję z tablicy argv[]

#include <stdio.h>
#include <ctype.h>

#define ALPHABET_SIZE 26
#define GRAPH_WIDTH 200

int main(int argc, char *argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Niepoprawne użycie programu\n");
		fprintf(stderr, "Użyj: %s <plik>\n", argv[0]);
		return 1;
	}

	FILE *file = fopen(argv[1], "r");
	if (file == NULL) {
		fprintf(stderr, "Nie udało się załadować pliku %s\n", argv[1]);
		return 2;
	}

	// Alfabet składa się z 26 liter
	// Duże i małe traktuję tak samo (case insensitive)
	// Pozostałe ignoruję
	unsigned int histogram[ALPHABET_SIZE] = {0};
	unsigned int total = 0;
	char letter;

	do {
		letter = fgetc(file);
		++total;
		if (isalpha(letter)) {
			int offset = tolower(letter) - 'a';
			++histogram[offset];
		}
	} while (letter != EOF);
	--total;
	
	for (int i = 0; i < ALPHABET_SIZE; ++i) {
		printf("%c: %d => %.1lf%%\n", 'a' + i, histogram[i], histogram[i] * 100.0 / total);
	}

	for (int i = 0; i < ALPHABET_SIZE; ++i) {
		printf("%c | ", 'a' + i);
		int width = GRAPH_WIDTH * histogram[i] / total;
		for (int i = 0; i < width; ++i) {
			putchar('*');
		}
		puts("");
	}

	fclose(file);
	return 0;
}
