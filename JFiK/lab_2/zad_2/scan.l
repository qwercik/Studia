%{
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);

  int x;
%}

%s s1
%s s2
%s s3

%%

<INITIAL>

%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
