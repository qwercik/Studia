#include <stdio.h>

int main(void) {
	unsigned int value;
	scanf("%u", &value);

	unsigned counter = 0;
	while (value) {
		if (value & 1) {
			// Cały kod poniżej to zwyczajna inkrementacja zmiennej counter
			// tylko zrealizowana przy pomocy operatorów bitowych (dla zasady)
			unsigned bitmask = 1;
			while (counter & bitmask) {
				counter &= ~bitmask;
				bitmask <<= 1;
			}

			counter |= bitmask;
		}

		value >>= 1;
	}

	printf("%d\n", counter);

	return 0;
}
