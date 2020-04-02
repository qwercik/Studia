#include <stdio.h>

int main(void) {
	int width, height;
	double array[50][50];
	
	printf("Podaj wysokość: ");
	scanf("%d", &height);

	printf("Podaj szerokość: ");
	scanf("%d", &width);
	
	for (int y = 0; y < height; ++y) {
		for (int x = 0; x < width; ++x) {
			scanf("%lf", &array[y][x]);
		}
	}

	for (int x = 0; x < width; ++x) {
		double max = array[0][x];
		for (int y = 1; y < height; ++y) {
			double value = array[y][x];
			if (value > max) {
				max = value;
			}
		}

		printf("Największa wartość w kolumnie nr %d to %lf\n", x, max);
	}

	return 0;
}
