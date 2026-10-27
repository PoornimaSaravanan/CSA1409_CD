
%{
#include <stdio.h>
%}

%%

abc     { printf("ABC"); }
.|\n    { printf("%s", yytext); }

%%

int yywrap(void)
{
    return 1;
}

int main(void)
{
    printf("Enter a string:\n");
    yylex();
    return 0;
}
