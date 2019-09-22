/* Scanner para uma linguagem C simplificada */

%option noyywrap

%{
	
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int numlines = 0;

/* Defining this macro stops a compiler warning about an unused
   function called "input" or "yyinput". */

#define YY_NO_INPUT

%}

/*
- include de biblioteca
- declaracao de metodo (com ou sem parametro)
- declaracao variavel (tipos: float)
- declaracao variavel com ponteiro
- atribuicao de variavel
- uso de variavel (com ponteiro e parenteses ou nao)
- array de variavel
- operadores aritmeticos (variavel ++)
- chamada de metodo (com ou sem parametro)
- declaracao operador condicional (if{})
- declaracao operador iteracao (for)
- retorno
- comentarios
- declaracao de array
*/

/* Macros for C preprocessor. */

ENDLINE       \r?\n

/* The `\\{ENDLINE}' is to deal with multiline CPP statements. */

CPP_SPACE     ([ \t\f\r]|\\{ENDLINE})+
CPP_OPT_SPACE ([ \t\f\r]|\\{ENDLINE})*

CPP_ANY       (.|\\{ENDLINE})
CPP           ^{CPP_OPT_SPACE}#{CPP_OPT_SPACE}

/* The macro C_SPACE has been set to match only a single `\n' in order
   to prevent collisions with {CPP}.  I don't know if there is
   anywhere in the rules that expects {C_SPACE} to match more than one
   `\n' - this might be a problem. */

C_SPACE       ([ \t\f\r]+|\n)
C_OPT_SPACE   [ \t\f\r\n]*
C_WORD        [A-Za-z_][A-Za-z_0-9]*
C_ARRAY       \[[^\][]*\]
C_VAR         (\*{C_OPT_SPACE})*{C_WORD}({C_OPT_SPACE}{C_ARRAY})*
C_VAR_NO_POINTER         {C_WORD}({C_OPT_SPACE}{C_ARRAY})*
C_FUNC_PTR    \({C_OPT_SPACE}\**{C_OPT_SPACE}{C_WORD}{C_OPT_SPACE}\)
BRACES \{[^{}]*\}
LINE_DIRECTIVE line{CPP_OPT_SPACE}[0-9]+{CPP_OPT_SPACE}\"([^\"]|\\\")+\"

%%


{ENDLINE}					 numlines++;


{CPP}if{CPP_ANY}*$             { printf("[reserved_word, %s]\n", yytext); }

{CPP}else{CPP_ANY}*$           { printf("[reserved_word, %s]\n", yytext); }

{CPP}elif{CPP_ANY}*$           { printf("[reserved_word, %s]\n", yytext); }

{CPP}endif{CPP_ANY}*$          { printf("[reserved_word, %s]\n", yytext); }












"/"(\\{ENDLINE})?"*"  {
                    if (YY_START != c_string) {
                      { printf("​[String, %s]\n ", yytext); }
                    }
                    else {
                      {}
                    } 
                  }

\*+\/  {}

(([^\*]|\n)*|\*+([^/\*]|\n))   {}

"/"(\\{ENDLINE})?"/".*    {}

typedef(\{(\{(\{({BRACES}|[^}{])*\}|{BRACES}|[^}{])*\}|{BRACES}|[^}{])*\}|{BRACES}|[^}{;])*; {} 






\,     			{ printf("​[comma, %s]\n ", yytext); }		 

\{   			{ printf("​[l_bracket, %s]\n ", yytext); }

\([^\)]*\) 		{}

([^\"]|\n)  	{}

\({C_OPT_SPACE}{C_OPT_SPACE}\)        {}
\({C_OPT_SPACE}void{C_OPT_SPACE}\)    { printf("[reserved_word, %s]\n", yytext); }







\({C_OPT_SPACE}\*{C_OPT_SPACE}     { printf("[function, %s]\n", yytext); }

\){C_OPT_SPACE}\(        		   { printf("[function, %s]\n", yytext); }

\)      						   { printf("[function, %s]\n", yytext); }

{C_WORD}   						   { printf("[function, %s]\n", yytext); }

[^\)]+     						   { printf("[function, %s]\n", yytext); }

\)  							   { printf("[function, %s]\n", yytext); }

\(   							   { printf("[function, %s]\n", yytext); }

[^\(\)]+  						   { printf("[function, %s]\n", yytext); }







\(                { printf("[argument_function, %s]\n", yytext); }

\)     			  { printf("[argument_function, %s]\n", yytext); }

\(   			  { printf("[argument_function, %s]\n", yytext); }

({C_VAR}|\*+)	  { printf("[argument_function, %s]\n", yytext); }

\,      		  { printf("[argument_function, %s]\n", yytext); }

{C_SPACE}     	  { printf("[argument_function, %s]\n", yytext); }

"..."  			  { printf("[argument_function, %s]\n", yytext); }

\{                        { printf("​[l_bracket, %s]\n ", yytext); }






\}                        { printf("​[r_bracket, %s]\n ", yytext); }

(\\[^\"])*            			  { printf("​[String, %s]\n ", yytext); }

(\\.|[^\\"])*         			  { printf("​[String, %s]\n ", yytext); }

([^\}\{\"]|\n|\'\\\"\'|\'\"\')    { printf("​[String, %s]\n ", yytext); }

\[[^]]*\]               		  { printf("​[array, %s]\n ", yytext); }

\;                	{ printf("​[semicolon, %s]\n ", yytext); }

=					{ printf("​[E​qual_Op, %s]\n ", yytext); }

\,                	{ printf("[argument_function, %s]\n", yytext); } 

main{C_OPT_SPACE}\([^\{]+\{  { printf("[reserved_word, %s]\n", yytext); }

static                  	 { printf("[reserved_word, %s]\n", yytext); }

void                    	 { printf("[reserved_word, %s]\n", yytext); }




void{C_OPT_SPACE}\*+   { printf("[reserved_word, %s]\n", yytext); }



%%

int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	return 0;
}



