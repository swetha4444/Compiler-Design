/*lex program for lexical analyzer*/
%{ 
#include<stdio.h> 
#include<string.h> 

typedef struct
{
	char var[10];
	char type[10];
	char value[10];
}symbol_table;

symbol_table t[10];
int ind=0;
char type[10];

int insert(char *token)
{
	int i;
	for(i=0;i<=ind;i++)
	{
		if(strcmp(token,t[i].var)==0)
			return 0;
	}
	return 1;
}
%}

keyword int|float|double|char|do|while|for|if|break|continue|void|return|else|string
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

{keyword} {
	printf("KEYWORD ");
	if(strcmp(yytext,"int")==0)
	{
		strcpy(type,yytext);
	}
	else if(strcmp(yytext,"float")==0)
	{
		strcpy(type,yytext);
	}
	else if(strcmp(yytext,"char")==0)
	{
		strcpy(type,yytext);
	}
	else if(strcmp(yytext,"double")==0)
	{
		strcpy(type,yytext);
	}
}
{function} printf("FUNCTION\t");
{sing_comment} printf("SINGLE-LINED COMMENT\t");
{multi_comment} printf("MULTI-LINED COMMENT\t");
{logical} printf("LOP\t");
{bitwise} printf("BOP\t");
{numconst} {
	printf("NUMCONST ");
	if(strcmp(t[ind].value,"null")==0)
	{
		strcpy(t[ind].value,yytext);
		ind++;
	}
}
{strconst} {printf("STRCONST ");}
{preprocessor} printf("PPDIR\t");
{identifier} {
	printf("ID\t");
	if(insert(yytext))
	{
		strcpy(t[ind].type,type);
		strcpy(t[ind].var,yytext);
		strcpy(t[ind].value,"null");
		ind++;
	}
}
{special_char} printf("SP\t");
{relational} printf("RELOP\t");
{arithmetic} printf("AOP\t");
{assign} {
	printf("ASSIGN ");
	ind--;
	}

%%

int yywrap(void){
    return 1;
} 

void main()
{	
	yyin=fopen("in.txt","r");
	yylex();
	int i;
	printf("\n\nType\tVariable\tValue\n");
	for(i=0;i<=ind;i++)
	{
		printf("%s\t%s\t%s\n",t[i].type,t[i].var,t[i].value);
	}
}
