%{
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);
  int n;
  int err;
%}
%s JEDYNKI
%%
<INITIAL>0 { putchar('0'); n++; }
<INITIAL>1 { putchar('1'); n--; BEGIN JEDYNKI; }
<JEDYNKI>1 { putchar('1'); n--; }
\n {
    if (n != 0) {
        err = 1;
    }
    
    if (err) {
        printf(" Error\n");
    } else {
        printf(" OK\n");
    }

    err = 0;
    n = 0;
    BEGIN INITIAL;
}
. { putchar(*yytext); err = 1; }

%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
