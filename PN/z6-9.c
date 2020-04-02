#include <stdio.h>
#define ARRAY_SIZE(array) (sizeof(array) / sizeof(*array))

typedef struct {
	int day;
	int month;
} Date;

typedef struct {
	char *name;
	Date startDate;
	Date endDate;
} ZodiacSign;

const ZodiacSign ZODIAC_SIGNS[] = {
	{"Koziorożec", {1, 1}, {19, 1}},
	{"Baran", {21, 3}, {19, 4}},
	{"Byk", {20, 4}, {20, 5}},
	{"Bliźnięta", {21, 5}, {20, 6}},
	{"Rak", {21, 6}, {22, 7}},
	{"Lew", {23, 7}, {22, 8}},
	{"Panna", {23, 8}, {22, 9}},
	{"Waga", {23, 9}, {22, 10}},
	{"Skorpion", {23, 10}, {21, 11}},
	{"Strzelec", {22, 11}, {21, 12}},
	{"Wodnik", {20, 1}, {18, 2}},
	{"Ryby", {19, 2}, {20, 3}},
	{"Koziorożec", {22, 12}, {31, 12}}
};


int date_compare(const Date *date1, const Date *date2) {
	if (date1->month == date2->month) {
		if (date1->day == date2->day) {
			return 0;
		} else {
			return date1->day > date2->day ? -1 : 1;
		}
	} else {
		return date1->month > date2->month ? -1 : 1;
	}
}

void date_print(const Date *date) {
	printf("%d.%d", date->day, date->month);
}

const ZodiacSign *findZodiac(const Date *date) {
	int i;
	for (i = 0; i < ARRAY_SIZE(ZODIAC_SIGNS); ++i) {
		if (
			date_compare(&ZODIAC_SIGNS[i].startDate, date) != -1 &&
			date_compare(date, &ZODIAC_SIGNS[i].endDate) != -1
		) {
			return &ZODIAC_SIGNS[i];
		}
	}

	return NULL;
}

int main(void) {
	Date date;
	printf("Podaj datę urodzin w formacie: dd.mm: ");
	scanf("%d.%d", &date.day, &date.month);

	const ZodiacSign *zodiacSign = findZodiac(&date);
	if (zodiacSign == NULL) {
		printf("Nie ma takiej daty panie kolego\n");
	} else {
		printf("Twój znak zodiaku to %s\n", zodiacSign->name);
	}
	
	return 0;
}
