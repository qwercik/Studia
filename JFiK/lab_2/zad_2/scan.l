%{
  // Nie działa to jeszcze najlepiej
  #include <stdio.h>
  int yywrap(void);
  int yylex(void);

  int hashes, dollars, percents;
  int max;
  int err;
%}
%s S1 
%s S2
%s S3
%%
<INITIAL>\#  hashes++;
<INITIAL>\$ { dollars++; BEGIN S1; }
<S1>\$  dollars++;
<S1>\% { percents++; BEGIN S2; }
<S2>\%  percents++;
<S2>\# {
    if (hashes != dollars || dollars != percents || hashes < max) {
        err = 1;
    }

    max = hashes;
    hashes = dollars = percents = 0;
    hashes++;
    BEGIN INITIAL;
}

\n {
    if (hashes != dollars || dollars != percents || hashes < max) {
        err = 1;
    }

    if (err) {
        puts("Error !!!");
    } else {
        puts("OK");
    }

    err = 0;
    hashes = dollars = percents = 0;
    max = 0;
    BEGIN INITIAL;
}

. {
    err = 1;
}
%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
