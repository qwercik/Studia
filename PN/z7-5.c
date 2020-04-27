#include <stdio.h>
#define COINS_NUMBER 9

int coin_identifier_to_index(char identifier) {
	const char *identifiers = "ctfdghKDF";

	for (int i = 0; i < COINS_NUMBER; ++i) {
		if (identifiers[i] == identifier) {
			return i;
		}
	}

	return -1;
}

// Zakładamy, że podajemy poprawny indeks
const char *index_to_coin_name(int index) {
	static const char* names[COINS_NUMBER] = {
		"jednogroszówka",
		"dwugroszówka",
		"pięciogroszówka",
		"dziesięciogroszówka",
		"dwudziestogroszówka",
		"pięćdziesięciogroszówka",
		"złotówka",
		"dwuzłotówka",
		"pięciozłotówka",
	};

	return names[index];
}

// Również zakładamy, że podajemy poprawny indeks
int index_to_coin_value(int index) {
	static const int values[COINS_NUMBER] = {1, 2, 5, 10, 20, 50, 100, 200, 500};

	return values[index];
}

int main(int argc, char *argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Niepoprawne użycie programu\n");
		fprintf(stderr, "Obsługa: %s <plik>\n", argv[0]);
		return 1;
	}
	
	FILE *file = fopen(argv[1], "r");
	if (file == NULL) {
		fprintf(stderr, "Nie udało się wczytać pliku\n");
		return 2;
	}

	int coins[COINS_NUMBER] = {0};

	char letter;
	do {
		letter = fgetc(file);

		int index = coin_identifier_to_index(letter);
		if (index != -1) {
			++coins[index];
		}
	} while (letter != EOF);
	
	int sum = 0;
	for (int i = 0; i < COINS_NUMBER; ++i) {
		printf("%s: %d szt.\n", index_to_coin_name(i), coins[i]);
		sum += coins[i] * index_to_coin_value(i);
	}

	printf("Razem: %d zł i %d gr\n", sum / 100, sum % 100);

	fclose(file);
	return 0;
}
