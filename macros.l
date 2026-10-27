
%{
#include <stdio.h>
#include <stdlib.h>

int macros = 0;
int headers = 0;
%}

%%

^[ \t]*#[ \t]*define[ \t]+[A-Za-z_][A-Za-z0-9_]*  { macros++; }
^[ \t]*#[ \t]*include[ \t]*[<"][^>\"]+[>"]       { headers++; }

%%

int yywrap(void)
{
    return 1;
}

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printf("Usage: %s <filename.c>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");

    if (yyin == NULL)
    {
        printf("Error: Cannot open file\n");
        return 1;
    }

    yylex();

    printf("Number of macros defined = %d\n", macros);
    printf("Number of header files included = %d\n", headers);

    fclose(yyin);
    return 0;
}
