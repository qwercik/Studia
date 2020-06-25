#include <stdio.h>
#include <stdlib.h>

#define ARRAY_SIZE(array) (sizeof(array) / sizeof(*array))

#define MATRIX_MAX_ROWS 10
#define MATRIX_COLUMNS 5

typedef struct Matrix {
	int data[MATRIX_MAX_ROWS][MATRIX_COLUMNS];
	int rows;
} Matrix;

void end_program(Matrix *matrix) {
	exit(0);
}

void read_matrix(Matrix *matrix) {
	printf("Ile wierszy ma mieć macierz? ");
	scanf("%d", &matrix->rows);

	if (matrix->rows < 0 || matrix->rows > MATRIX_MAX_ROWS) {
		fprintf(stderr, "Nie wczytam takiej macierzy!\n");
		return;
	}

	for (int i = 0; i < matrix->rows; ++i) {
		for (int j = 0; j < MATRIX_COLUMNS; ++j) {
			scanf("%d", &matrix->data[i][j]);
		}
	}
}

void sum_bigger_than_x(Matrix *matrix) {
	int x;
	printf("Podaj x: ");
	scanf("%d", &x);

	for (int i = 0; i < matrix->rows; ++i) {
		int sum = 0;
		for (int j = 0; j < MATRIX_COLUMNS; ++j) {
			if (matrix->data[i][j] > x) {
				sum += matrix->data[i][j];
			}
		}

		printf("Wiersz nr %d: %d\n", i + 1, sum);
	}
}

void multiply_first_n_elements(Matrix *matrix) {
	int n;
	printf("Podaj n: ");
	scanf("%d", &n);

	if (n < 0 || n > matrix->rows) {
		fprintf(stderr, "Nie policzę Ci iloczynu dla %d wierszy, bo tyle nie ma\n", n);
		return;
	}

	for (int i = 0; i < MATRIX_COLUMNS; ++i) {
		int product = 1;
		for (int j = 0; j < n; ++j) {
			product *= matrix->data[j][i];
		}
		
		printf("Iloczyn %d pierwszych elementów kolumny nr %d: %d\n", n, i + 1, product);
	}
}

void number_of_rows_with_first_bigger_than_last(Matrix *matrix) {
	int number = 0;
	for (int i = 0; i < matrix->rows; ++i) {
		if (matrix->data[i] > matrix->data[MATRIX_MAX_ROWS - 1]) {
			number++;
		}
	}

	printf("Liczba wierszy, w których początkowy element jest większy od ostatniego, wynosi: %d\n", number);
}

void number_of_columns_with_at_least_one_zero(Matrix *matrix) {
	int number = 0;
	for (int i = 0; i < MATRIX_COLUMNS; ++i) {
		for (int j = 0; j < matrix->rows; ++j) {
			if (matrix->data[j][i] == 0) {
				number++;
				break;
			}
		}
	}

	fprintf(stderr, "Liczba kolumn z przynajmniej jednym zerem: %d\n", number);
}

int main(void) {
	void (*callbacks[])(Matrix*) = {
		end_program,
		read_matrix,
		sum_bigger_than_x,
		multiply_first_n_elements,
		number_of_rows_with_first_bigger_than_last,
		number_of_columns_with_at_least_one_zero
	};

	Matrix matrix = {
		.rows = 0	
	};

	int choice = 0;
	do {
		printf("Wybierz: ");
		scanf("%d", &choice);

		if (choice < 0 || choice >= ARRAY_SIZE(callbacks)) {
			fprintf(stderr, "Wybierz poprawną opcję!\n");
			continue;
		}

		callbacks[choice](&matrix);
	} while (choice != 0);

	return 0;
}
