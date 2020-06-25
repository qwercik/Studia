#include <stdio.h>
#include <string.h>

#define FIRSTNAME_SIZE 16
#define SURNAME_SIZE 64
#define PESEL_SIZE 12 // 11 digits + null character
#define WORKERS_NUMBER 100

typedef struct Worker {
	int exist;
	char firstname[FIRSTNAME_SIZE];
	char surname[SURNAME_SIZE];
	char pesel[PESEL_SIZE];
} Worker;

void Worker__init(Worker *worker) {
	worker->exist = 0;
}

void Worker__display(Worker *worker) {
	printf("%s %s: %s", worker->firstname, worker->surname, worker->pesel);
}

typedef struct Company {
	Worker workers[WORKERS_NUMBER];
	unsigned int workersNumber;
} Company;

void Company__init(Company *company) {
	company->workersNumber = 0;
	for (int i = 0; i < WORKERS_NUMBER; ++i) {
		Worker__init(&company->workers[i]);
	}
}

void Company__add_worker(Company *company) {
	Worker *current = &company->workers[company->workersNumber];

	printf("Podaj imię: ");
	scanf("%15s", current->firstname);

	printf("Podaj nazwisko: ");
	scanf("%63s", current->surname);

	printf("Podaj PESEL: ");
	scanf("%11s", current->pesel);

	current->exist = 1;
	company->workersNumber++;
}

void Company__display_all(Company *company) {
	for (int i = 0; i < company->workersNumber; ++i) {
		Worker *current = &company->workers[i];
		if (current->exist) {
			Worker__display(current);
			printf("\n");
		}
	}
}

void Company__find_worker(Company *company) {
	char pesel[PESEL_SIZE];
	printf("Podaj PESEL: ");
	scanf("%11s", pesel);

	for (int i = 0; i < company->workersNumber; ++i) {
		Worker *worker = &company->workers[i];
		if (worker->exist && strncmp(pesel, worker->pesel, PESEL_SIZE - 1) == 0) {
			printf("Znaleziono pracownika!\n");
			Worker__display(worker);
			printf("\n");
			return;
		}
	}

	printf("Nie znaleziono pracownika o podanym PESELu\n");
}

void Company__delete_worker(Company *company) {
	char surname[SURNAME_SIZE];
	printf("Podaj nazwisko: ");
	scanf("%63s", surname);

	for (int i = 0; i < company->workersNumber; ++i) {
		Worker *worker = &company->workers[i];
		if (worker->exist && strncmp(surname, worker->surname, SURNAME_SIZE - 1) == 0) {
			printf("Usuwam pracownika\n");
			Worker__display(worker);
			printf("\n");

			worker->exist = 0;
		}
	}
}

void Company__save_to_file(Company *company) {
	char filename[100];
	printf("Podaj nazwę pliku: ");
	scanf("%99s", filename);

	FILE *file = fopen(filename, "w");
	if (file == NULL) {
		fprintf(stderr, "Nie udało się zapisać danych do pliku\n");
		return;
	}

	fprintf(file, "%d\n", company->workersNumber);

	for (int i = 0; i < company->workersNumber; ++i) {
		Worker *current = &company->workers[i];
		fprintf(file, "%d %s %s %s\n", current->exist, current->firstname, current->surname, current->pesel);	
	}

	fclose(file);
}

void Company__read_from_file(Company *company) {
	char filename[100];
	printf("Podaj nazwę pliku: ");
	scanf("%99s", filename);

	FILE *file = fopen(filename, "r");
	if (file == NULL) {
		fprintf(stderr, "Nie udało się wczytać danych z pliku!\n");
		return;
	}

	fscanf(file, "%d", &company->workersNumber);
	for (int i = 0; i < company->workersNumber; ++i) {
		Worker *current = &company->workers[i];
		fscanf(file, "%d %s %s %s", &current->exist, current->firstname, current->surname, current->pesel);
	}

	fclose(file);
}

int main(void) {
	Company company;
	Company__init(&company);

	void (*callbacks[])(Company*) = {
		Company__add_worker,
		Company__display_all,
		Company__find_worker,
		Company__delete_worker,
		Company__save_to_file,
		Company__read_from_file
	};

	char choose;
	printf("Wybierz opcję: ");
	scanf("%c", &choose);


	while (choose >= 'A' && choose <= 'F') {
		callbacks[choose - 'A'](&company);
		
		printf("Wybierz opcję: ");
		scanf(" %c", &choose);
	}

	return 0;
}
