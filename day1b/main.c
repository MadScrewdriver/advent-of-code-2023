#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int _extract(int n, char *line);
extern int _sum(int n, int *extracted);


int main() {
    char line[256];
    int extracted[2048];

    FILE *file = fopen("../output.txt", "r");
    int line_count = 0;

    while (fgets(line, sizeof(line), file) != NULL) {
        extracted[line_count] = _extract(strlen(line), line);
        line_count++;
    }

    fclose(file);

    int sum = _sum(line_count, extracted);
    printf("%d\n", sum);

    return 0;
}
