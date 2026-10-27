
%{
#include <stdio.h>
#include <stdlib.h>
%}

%%

"<"[^>]+">"    { printf("%s\n", yytext); }

%%

int yywrap(void)
{
    return 1;
}

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printf("Usage: %s <filename.html>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");

    if (yyin == NULL)
    {
        printf("Error: Cannot open file\n");
        return 1;
    }

    yylex();

    fclose(yyin);
    return 0;
}
