%{
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);
%}
%s DALEJ
%%
<INITIAL>\  ;
<INITIAL>. { putchar(*yytext); BEGIN DALEJ; }
<DALEJ>\n { putchar('\n'); BEGIN INITIAL; }
<DALEJ>. putchar(*yytext);
%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
