/* Scanner para uma linguagem Pascal simplificada */

%option noyywrap

%{

#include <math.h>
int numLines = 1;

char colour[30][30] = {};

%}

ENDLINE     \r?\n
WORD        [A-Za-z_][A-Za-z_0-9]*
SPACE   	[ \t\f\r\n]*
ARRAY       \[[^\][]*\]
VAR         (\*{SPACE})*{WORD}({SPACE}{ARRAY})*

%%

;|;{ENDLINE} 	numLines++;{ printf("\n\n------- Linha: %d\n", numLines); }

int|if          { printf("[reserved_word, %s]", yytext); }

{VAR}			{ printf("[id, %s]", yytext); }

%%

int main(int argc, char *argv[]){
	printf("----- Linha: 1\n", yytext);
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	return 0;
}
