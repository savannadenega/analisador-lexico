/* Scanner para uma linguagem Pascal simplificada */

%option noyywrap

%{

#include <math.h>

%}


DIGIT	[0-9]
ID	[a-z][a-z0-9]*


%%

{DIGIT}+ { printf("Numero inteiro encontrado: %s (%d)\n", yytext, atoi(yytext));}

{DIGIT}"."{DIGIT}* {printf("Numero float encontrado: %s (%f)\n", yytext, atof(yytext));}

if|then|begin|procedure|function	{
		printf("Palavra reservada encontrada: %s\n ", yytext);}

{ID}	{printf("Identificador encontrado: %s\n", yytext);}

"+"|"-"|"*"|"/" {printf("Operador encontrado: %s\n", yytext);}

"{"[\^{}}\n]*"}"	

[ \t\n]+		

.	printf("Caractere nao reconhecido: %s\n", yytext);

%%

int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	return 0;
}
