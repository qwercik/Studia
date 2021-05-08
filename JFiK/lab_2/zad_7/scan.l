%{
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);
%}
%s LISTA
%%
<INITIAL>[A-Za-z]+ { printf("%s", yytext); }
<INITIAL>[\ \t] { printf(":   "); BEGIN LISTA; }
<LISTA>[\ \t] ;
<LISTA>\n { puts(""); BEGIN INITIAL; }
%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
