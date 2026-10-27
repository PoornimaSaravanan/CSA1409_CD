
%{
#include <stdio.h>
%}

%%

[A-Z]+    { printf("Capital word: %s\n", yytext); }
.|\n      ;

%%

int yywrap(void)
{
    return 1;
}

int main(void)
{
    printf("Enter the input:\n");
    yylex();
    return 0;
}
