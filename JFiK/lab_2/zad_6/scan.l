%{
  #include <stdio.h>
  #include <assert.h>
  #define STACK_SIZE 16
  int yywrap(void);
  int yylex(void);

  // Są wyzerowane
  int stack[STACK_SIZE];
  int stack_pointer;
%}
%%
[0-9]+ {
    assert(stack_pointer < STACK_SIZE);
    sscanf(yytext, "%d", &stack[stack_pointer++]);
}
\+ {
    assert(stack_pointer > 0);
    stack[stack_pointer - 2] += stack[stack_pointer - 1];
    stack_pointer--;
}
\* {
    assert(stack_pointer > 0);
    stack[stack_pointer - 2] *= stack[stack_pointer - 1];
    stack_pointer--;
}
\  ;
\n {
    assert(stack_pointer == 1);
    printf("%d\n", stack[--stack_pointer]);
}
%%
int yywrap(void) { return 1; }
int main(void) { return yylex(); }
