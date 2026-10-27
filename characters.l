%{
#include <stdio.h>
#include <stdlib.h>

// Global variable counters initialized to zero
int nchar = 0;
int nword = 0;
int nline = 0;
%}

%%

\n          { nline++; nchar++; }
[^ \t\n]+   { nword++; nchar += yyleng; }
.           { nchar++; }

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <filename.c>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("Error: Could not open file '%s'\n", argv[1]);
        return 1;
    }

    yylex();

    printf("Number of characters = %d\n", nchar);
    printf("Number of words = %d\n", nword);
    printf("Number of lines = %d\n", nline);

    fclose(yyin);
    return 0;
}