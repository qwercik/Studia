#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define ITEMS_NUMBER 50
#define ITEM_NAME_SIZE 20

const char* const AVAILABLE_COMMANDS = "h (pomoc), n (nowy), w (wypisz), r (razem), q (zakończ),";

typedef struct {
	char name[ITEM_NAME_SIZE];
	size_t pieces;
	double price;
} Item;

typedef struct {
	Item items[ITEMS_NUMBER];
	size_t currentIndex;
} ItemsRegister;

void ItemsRegister_init(ItemsRegister *itemsRegister) {
	itemsRegister->currentIndex = 0;
}

void ItemsRegister_new(ItemsRegister *itemsRegister, const char *name, size_t pieces, double price) {
	strncpy(itemsRegister->items[itemsRegister->currentIndex].name, name, ITEM_NAME_SIZE - 1);
	itemsRegister->items[itemsRegister->currentIndex].pieces = pieces;
	itemsRegister->items[itemsRegister->currentIndex].price = price;

	itemsRegister->currentIndex++;
}

void ItemsRegister_print(const ItemsRegister *itemsRegister) {
	for (size_t index = 0; index < itemsRegister->currentIndex; ++index) {
		printf(
			"%s - %.2lf (%lu szt.)\n",
			itemsRegister->items[index].name,
			itemsRegister->items[index].price,
			itemsRegister->items[index].pieces
		);
	}
}

double ItemsRegister_total(const ItemsRegister *itemsRegister) {
	double sum = 0;
	for (size_t index = 0; index < itemsRegister->currentIndex; ++index) {
		sum += itemsRegister->items[index].price * itemsRegister->items[index].pieces;
	}

	return sum;
}

void stdin_clear(void) {
	char c;
	while ((c = getchar()) != '\n' && c != EOF) {
		// Do nothing
	}
}

int main(void) {
	ItemsRegister itemsRegister;
	ItemsRegister_init(&itemsRegister);

	char choice;

	printf("Witaj w programie do zarządzania towarami\n");
	printf("Dostępne komendy: %s\n", AVAILABLE_COMMANDS);

	do {
		printf("Twój wybór: ");
		scanf("%c", &choice);
		choice = tolower(choice);
		
		if (choice == 'n') {
			printf("Tworzenie nowego towaru\n");
			printf("\tPodaj nazwę: ");
			
			char buffer[ITEM_NAME_SIZE];
			scanf("%s", buffer);

			printf("\tPodaj cenę detaliczną: ");
			double price;
			scanf("%lf", &price);

			printf("\tPodaj ilość sztuk: ");
			size_t pieces;
			scanf("%lu", &pieces);
	
			ItemsRegister_new(&itemsRegister, buffer, pieces, price);
		} else if (choice == 'w') {
			ItemsRegister_print(&itemsRegister);
		} else if (choice == 'r') {
			double total = ItemsRegister_total(&itemsRegister);

			printf("Całkowita wartość: %.2lf zł\n", total);
		} else if (choice == 'h' || choice == '?') {
			printf("Komendy: %s\n", AVAILABLE_COMMANDS);
		} else if (choice != 'q') {
			fprintf(stderr, "Niepoprawna komenda. Wybierz jedną z następujących: %s\n", AVAILABLE_COMMANDS);
		}
		
		stdin_clear();
	} while (choice != 'q');

	return 0;
}
