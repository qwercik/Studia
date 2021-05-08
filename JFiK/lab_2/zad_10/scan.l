%{
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);
%}
%%
[0-9]+ { printf("%s %s", yytext, yytext); }
. { putchar(*yytext); }
%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
