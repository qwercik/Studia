%{
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);
%}
%%
[A-Za-z\n] { putchar(*yytext); }
[^A-Za-z\n] { putchar('.'); }
%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
