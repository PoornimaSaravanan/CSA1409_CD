
%{
#include <stdio.h>
#include <stdlib.h>

int count = 0;
FILE *out;
%}

%%

"//".*                  { count++; }
"/*"([^*]|\*+[^*/])*\*+"/"  { 
                            count++;
                         }
\n                      { fprintf(out, "\n"); }
.                       { fprintf(out, "%s", yytext); }

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
        printf("Error: Cannot open input file\n");
        return 1;
    }

    out = fopen("output.c", "w");
    if (out == NULL)
    {
        printf("Error: Cannot create output file\n");
        fclose(yyin);
        return 1;
    }

    yylex();

    printf("Number of comment lines = %d\n", count);
    printf("Comments removed successfully.\n");
    printf("Output written to output.c\n");

    fclose(yyin);
    fclose(out);
    return 0;
}
