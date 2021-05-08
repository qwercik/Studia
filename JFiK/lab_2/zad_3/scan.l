%{
  // To jest dość uproszczona wersja zadania, bo nie wiem czy chodzi mu tylko o trójkąt z przeciwprostokątną po prawej stronie, czy może także po lewej
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);
  int current_in_row = 0;
  int should_be_in_row = 1;
  int err = 0;
%}
%%
X   current_in_row++;
\n  {
    if (current_in_row != should_be_in_row) {
        err = 1;
    }

    should_be_in_row++;
    current_in_row = 0;
}
.   err = 1;



%%
int yywrap(void) { return 1; }
int main(void) {
    int result = yylex();

    if (err) {
        puts("yylex:Error!");
    } else {
        puts("OK!");
    }

    return result;
}
