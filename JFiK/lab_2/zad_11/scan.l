%{
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);
%}
%%
[bB][eE][gG][iI][nN] { printf("KWD"); }
[eE][nN][dD] { printf("KWD"); }
[A-Za-z_][A-Za-z_0-9]* { printf("ID"); }
. { putchar(*yytext); }
%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
