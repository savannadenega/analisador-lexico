# analisador-lexico

Projeto para desenvolvimento de uma aplicação de análise léxica para a disciplina de Tradutores Unisinos-2019.


### Ferramentas

- Aplicação [Flex](https://github.com/westes/flex)


### Como executar

- Necesário instalar e configurar os itens no link: [Get Started with FLEX/LEX Programming](https://codedost.com/flex/)

- Para executar no `SO Windows`, use os comandos abaixo:

``
cd local_do_arquivo

flex ctoy.lex

gcc ctoy.c (ou lex.yy.c) -o ctoy

ctoy.exe            
``

