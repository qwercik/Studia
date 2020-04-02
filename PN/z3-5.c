#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define WORD_SIZE 20
#define TEXT_WORDS_MAX_NUMBER 100
#define DICTIONARY_WORDS_MAX_NUMBER 10

typedef struct {
	char before[WORD_SIZE];
	char after[WORD_SIZE];
} Translation;

int main(void) {
	char words[TEXT_WORDS_MAX_NUMBER][WORD_SIZE];
	Translation dictionary[DICTIONARY_WORDS_MAX_NUMBER];
	int i, j;
	int ret;
	int wordsCounter = 0;
	int translationsCounter = 0;
	
	printf("Podaj wyrazy: ");
	for (i = 0; i < TEXT_WORDS_MAX_NUMBER; ++i) {
		ret = scanf("%s", words[i]);
		if (ret != 1 || strcmp(words[i], "@") == 0) {
			break;
		}

		wordsCounter++;
	}

	printf("\n");
	
	printf("Podaj tłumaczenia: ");
	for (i = 0; i < DICTIONARY_WORDS_MAX_NUMBER; ++i) {
		ret = scanf("%s", dictionary[i].before);
		fprintf(stderr, "[DBG] %d\n", ret);
		if (ret != 1 || strcmp(dictionary[i].before, "@") == 0) {
			break;
		}
		
		ret = scanf("%s", dictionary[i].after);
		if (ret != 1 || strcmp(dictionary[i].after, "@") == 0) {
			break;
		}

		translationsCounter++;
	}


	for (i = 0; i < wordsCounter; ++i) {
		for (j = 0; j < translationsCounter; ++j) {
			if (strcmp(words[i], dictionary[j].before) == 0) {
				strncpy(words[i], dictionary[j].after, WORD_SIZE);
			}
		}

		printf("%s ", words[i]);
	}

	return 0;
}
