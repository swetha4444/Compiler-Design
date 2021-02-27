%{
    #include<stdio.h>
%}

keywords int|float|double|char|do|while|for|if|break|continue|void|return|else|string
function main|printf|scanf|getchar|getch
strconst \".*\"
preprocessor #.+
identifier [_a-zA-Z][a-zA-Z0-9]*
numconst [0-9]+|[0-9]+[.][0-9]+
special_char [{}(),;]
sing_comment [//].*
multi_comment "/*"(.|\n)*"*/"
relational "<="|">="|"<"|"=="|">" 
arithmetic "+"|"-"|"--"|"++"|"%"|"*"|"/"
assign "="|"+="|"-="|"/="|"%="
logical "||"|"&&"
bitwise "<<"|">>"|"^"|"~"

%%
{keywords} printf("KEYWORD\t");
{function} printf("FUNCTION\t");
{preprocessor} printf("PPDIR\t");
{identifier} printf("ID\t");
{numconst} printf("NUMCONST\t");
{strconst} printf("STRCONST\t");
{special_char} printf("SP\t");
{sing_comment} printf("SINGLE-LINED COMMENT\t");
{multi_comment} printf("MULTI-LINED COMMENT\t");
{relational} printf("RELOP\t");
{arithmetic} printf("AOP\t");
{logical} printf("LOP\t");
{bitwise} printf("BOP\t");
{assign} printf("ASSIGN\t");
%%

int yywrap()
{
    return 1;
}

void main()
{
    yyin=fopen("in.txt","r");
    yylex();
}