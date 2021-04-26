%{
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);
%}
%%
 /* == rules == */
.|\n     {  printf("Unexpected character in input file\n");
            return -1;
          }
%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
