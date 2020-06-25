#include <stdio.h>
#include <stdlib.h>

void allocate_2d_matrix(unsigned int ***matrix, unsigned int rows, unsigned int columns) {
	*matrix = malloc(rows * sizeof(unsigned int*));
	for (unsigned int i = 0; i < rows; ++i) {
		(*matrix)[i] = malloc(columns * sizeof(unsigned int));
	}
}

void free_2d_matrix(unsigned int ***matrix, unsigned int rows) {
	for (unsigned int i = 0; i < rows; ++i) {
		free((*matrix)[i]);
	}

	free(*matrix);
}

int is_cell_ok(unsigned int value) {
	return (value & 0xF) == 0x2 && ((value >> (8 * sizeof(value) - 4)) & 0xF) == 0xB;
}

int main(void) {
	unsigned int rows, columns;
	printf("Podaj wiersze: ");
	scanf("%u", &rows);
	printf("Podaj kolumny: ");
	scanf("%u", &columns);

	unsigned int **matrix;
	allocate_2d_matrix(&matrix, rows, columns);

	for (unsigned int i = 0; i < rows; ++i) {
		for (unsigned int j = 0; j < columns; ++j) {
			scanf("%u", &matrix[i][j]);
		}
	}

	for (unsigned int i = 0; i < columns; ++i) {
		if (is_cell_ok(matrix[0][i])) {
			for (unsigned int j = 1; j < rows; ++j) {
				printf("%u ", matrix[j][i]);
			}

			printf("\n");
		}
	}

	free_2d_matrix(&matrix, rows);

	return 0;
}
