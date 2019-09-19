/* Scanner para uma linguagem Pascal simplificada */

/* ------------- definições regulares ------------- */

%option noyywrap

%{

#include <math.h>
int numlines = 0;
int numOperators = 1;


%}


DIGIT [0-9]*
ID [A-Za-z][A-Za-z0-9]*
STRING   \"([^\\\"]|\\.)*\"
COMMENT  \|\|.*\n
WHITE_ESPACE  [\n|\s|\t\r]





%%


int|if|void|for|return|else|string|NULL|scanf|printf { printf("[reserved_word, %s]\n", yytext); } 



{ID} { printf("​[id, %s]\n", yytext); } numOperators++;

"=" { printf("​[E​qual_Op, %s]\n ", yytext); }

"!="|"<"|"<="|"=="|">="|">" { printf("​[relational_Op, %s]\n ", yytext); }

"||"|"&&" { printf("​[Logical_Op, %s]\n ", yytext); }

"+"|"-"|"*"|"/" { printf("​[​Arith_​Op, %s]\n ", yytext); }

"(" { printf("​[l_​paren, %s\n ", yytext); }

")" { printf("​[​r_paren, %s]\n ", yytext); }

"{" { printf("​[l_bracket, %s]\n ", yytext); }

"}" { printf("​[r_bracket, %s]\n ", yytext); }

"," { printf("​[comma, %s]\n ", yytext); }

";" { printf("​[semicolon, %s]\n ", yytext); }

"[" { printf("​[r_esquare_bracket, %s]\n ", yytext); }

"]" { printf("​[r_square_bracket, %s]\n ", yytext); }

"#" { printf("​[number_sign, %s]\n ", yytext); }

":" { printf("​[colon, %s]\n ", yytext); }

"%" { printf("​[remainder, %s]\n ", yytext); }


{STRING} {printf("​[String, %s]\n ", yytext); }

{DIGIT} { printf("​[num, %s (%d)]\n ", yytext,atoi(yytext)); } 


{WHITE_ESPACE} {}

{COMMENT} {}

{DIGIT}*"."{DIGIT}* { printf("​[num, %s (%f)]\n ",yytext, atof(yytext)); } 

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



