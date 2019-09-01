%option noyywrap

%{

#include <stdio.h>
#include <time.h>

%}

%%
"<date>" {time_t t;
	  time(&t);
	  printf("%s", ctime(&t));}
%%

int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	return 0;
}
