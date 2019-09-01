%option noyywrap

%{

#include <stdio.h>
#include <time.h>

int numlines = 0;
int numchars = 0;


%}

%%

\n	numlines++; numchars++;
.	numchars++;

%%

int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	printf("Número de caracteres: %d\n", numchars);
	printf("Número de linhas: %d\n", numlines);
	return 0;
}
