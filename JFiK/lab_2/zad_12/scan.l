%{
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);
%}
%%
\[[^\n\]]*\] puts(yytext);
.   {}
\n  ;
%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
