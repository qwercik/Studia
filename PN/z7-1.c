#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_WORKERS_NUMBER 50
#define MAX_NAME_SIZE 50

typedef struct {
	char name[MAX_NAME_SIZE];
	unsigned int salary;
} Worker;

typedef struct {
	Worker workers[MAX_WORKERS_NUMBER];
	size_t workersNumber;
} Company;


void clear_buffer(FILE *stream) {
	char character;
	do {
		character = fgetc(stream);
	} while (character != '\n' && character != EOF);
}

char stdin_read_char(void) {
	char character = getchar();
	if (character != '\n') {
		clear_buffer(stdin);
	}

	return character;
}

void company__init(Company *company) {
	company->workersNumber = 0;
}

bool company__load_from_file(Company *company, const char *filename) {
	FILE *file = fopen(filename, "r");
	if (file == NULL) {
		perror("fopen");
		return false;
	}
	
	// Zakładamy, że ładowanie z pliku nadpisuje poprzednich pracowników
	company->workersNumber = 0;

	while (!feof(file)) {
		Worker *currentWorker = &company->workers[company->workersNumber];
		
		if (fscanf(file, "%s %u", currentWorker->name, &currentWorker->salary) != 2) {
			break;
		}

		// Zabezpieczamy się przed tym, żeby nie wczytać zbyt dużo pracowników
		// Może to być niezbezpieczne ze względu na buffer overflow
		if (company->workersNumber != MAX_WORKERS_NUMBER - 1) {
			company->workersNumber++;
		} else {
			break;
		}
	}

	fclose(file);
	return true;
}

void company__print_workers(Company *company) {
	printf("Pracownicy firmy:\n");
	for (size_t i = 0; i < company->workersNumber; ++i) {
		Worker *currentWorker = &company->workers[i];
		printf("%lu | %s | %u\n", i + 1, currentWorker->name, currentWorker->salary);
	}

	printf("Razem: %lu\n", company->workersNumber);
}

bool company__create_worker(Company *company) {
	if (company->workersNumber == MAX_WORKERS_NUMBER - 1) {
		return false;
	}

	Worker *currentWorker = &company->workers[company->workersNumber];
	
	printf("Podaj nazwisko: ");
	scanf("%s", currentWorker->name);

	printf("Podaj wynagrodzenie: ");
	scanf("%u", &currentWorker->salary);
		
	clear_buffer(stdin);
	company->workersNumber++;
	return true;
}

bool company__write_to_file(Company *company, const char *filename) {
	// Nadpisujemy, trzeba o tym pamiętać!
	FILE *file = fopen(filename, "w");

	if (file == NULL) {
		return false;
	}

	for (size_t i = 0; i < company->workersNumber; ++i) {
		Worker *currentWorker = &company->workers[i];
		
		fprintf(file, "%s %u\n", currentWorker->name, currentWorker->salary);
	}

	fclose(file);
}

int main(void) {
	char filename[100];
	
	Company company;
	company__init(&company);

	char choose;
	do {
		printf("Twój wybór: ");
		choose = stdin_read_char();

		switch (choose) {
		case 'R':
			printf("Podaj nazwę pliku: ");
			scanf("%99s", filename);
			clear_buffer(stdin);

			if (company__load_from_file(&company, filename)) {
				printf("Pomyślnie załadowano plik: %s\n", filename);
			} else {
				printf("Wystąpił błąd ładowania z pliku: %s\n", filename);
			}

			break;
		
		case 'N':
			if (company__create_worker(&company)) {
				printf("Dodano nowego pracownika\n");
			} else {
				printf("Nie udało się dodać nowego pracownika\n");
			}

			break;

		case 'W':
			company__print_workers(&company);
			break;

		case 'Z':
			printf("Podaj nazwę pliku: ");
			scanf("%99s", filename);
			clear_buffer(stdin);

			company__write_to_file(&company, filename);
			break;

		case 'K':
			printf("Do widzenia!\n");
			break;

		default:
			printf("Wybrałeś niepoprawną opcję!\n");
		}

	} while (choose != 'K');
	
	return 0;
}
