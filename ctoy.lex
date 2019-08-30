/* Scanner para uma linguagem Pascal simplificada */

/* ------------- definições regulares ------------- */

%option noyywrap

%{

#include <math.h>
int numlines = 0;
int numOperators = 1;

%}


DIGIT [0-9]*
ID [a-z][a-z0-9]*


%%
/* ------------- regras ------------- */

/* contagem de linhas */
\n	{ printf(\nnumlines\n); } numlines++;

int|if { printf("[reserved_word, int] "); } /* ------------- descobrir como pegar a palavra reservada e imprimir ------------- */

{ID} { printf("​[id, %d]​ ", numOperators); } numOperators++;

= { printf("​[E​qual_Op, =​] "); }

!= { printf("​[Relational_Op, !=] "); }

+ { printf("​[​Arith_​Op, +] "); }

{DIGIT} { printf("​[num, 52] "); } /* ------------- descobrir como pegar numero e imprimir ------------- */

{DIGIT}*"."{DIGIT}* { printf("​[num, 52] "); } /* ------------- descobrir como pegar numero e imprimir ------------- */




/* ------------- CONTINUAR A PARTIR DE: Remoção de espaços em branco e comentários: no trabalho ------------- */


/*

{DIGIT}+ { printf("Numero inteiro encontrado: %s (%d)\n", yytext, atoi(yytext));}

{DIGIT}"."{DIGIT}* {printf("Numero float encontrado: %s (%f)\n", yytext, atof(yytext));}

if|then|begin|procedure|function	{
		printf("Palavra reservada encontrada: %s\n ", yytext);}

{ID}	{printf("Identificador encontrado: %s\n", yytext);}

"+"|"-"|"*"|"/" {printf("Operador encontrado: %s\n", yytext);}

"{"[\^{}}\n]*"}"

[ \t\n]+

.	printf("Caractere nao reconhecido: %s\n", yytext);

*/


%%
/* ------------- código de usuário ------------- */

int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	return 0;
}
