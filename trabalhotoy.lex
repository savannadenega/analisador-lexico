/* Scanner para uma linguagem Pascal simplificada */

%option noyywrap

%{

#include <string.h>
#include <stdbool.h>
#include <stdio.h>
#include <math.h>
int numLines = 1;

char varIds[30][30] = {};
int actualId = 1;
bool breakStrcmp = false;

%}

ENDLINE     \r?\n
WORD        [A-Za-z_][A-Za-z_0-9]*
SPACE   	[ \t\f\r\n]*
ARRAY       \[[^\][]*\]
VAR         (\*{SPACE})*{WORD}({SPACE}{ARRAY})*

%%

;|;{ENDLINE} 	numLines++;{ printf("\n\n------- Linha: %d\n", numLines); }

int|if          { printf("[reserved_word, %s]", yytext); }

{VAR}			{ 

	int i;
	for (i = 0; i < sizeof(varIds); i++){
        if(strcmp(&yytext[0], varIds[i]) == 0){
			printf("[id, %d]", i);
			breakStrcmp = true;
			break;
		}
	}
	if(!breakStrcmp){
		strcpy(varIds[actualId], &yytext[0]);
		printf("[id, %d]", actualId);
		actualId++;
	}else{
		breakStrcmp = false;
	}
	
	}

= 			{ printf("[Equal_Op, %s]", yytext); }
	
%%

int main(int argc, char *argv[]){
	printf("----- Linha: 1\n", yytext);
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	return 0;
}
