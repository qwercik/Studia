%{
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);

  int x, y;
%}

%s PART_1
%s PART_2
%s PART_3

%%
<INITIAL>\      ;
<INITIAL>[0-9]+ { sscanf(yytext, "%d", &x); x = (x - 1) * 6 - 1; }
<INITIAL>\n     { y = x; BEGIN PART_1; }

<PART_1>.       { if (y) { y--; } else { y = 6; BEGIN PART_2; } }
<PART_2>.       { if (y) { y--; ECHO;} else { BEGIN PART_3; } }
<PART_3>[^\n]   ;
<PART_3>\n      { y = x; BEGIN PART_1; ECHO; }
%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
