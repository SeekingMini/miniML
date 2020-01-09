%{
  open Syntax
%}

%token <int> INT
%token <string> ID

%token IF THEN ELSE TRUE FALSE
%token PLUS MINUS MUL DIV
%token EOF EOL
%token LPAREN RPAREN
%token LET EQUAL LT LE GT GE OR AND NOT NEQ

%left OR
%left AND
%left LT LE GT GE EQ NEQ
%left PLUS MINUS
%left MUL DIV
%left LPAREN RPAREN

%nonassoc NOT
%type <Syntax.t> main
%start main

%%

main:
 |EOL {Empty}                              
 |expr EOL {$1}                            
 |LET ID EQUAL expr EOL {Let($2,$4)}       
expr:
 | INT
     {Int($1)}
 | TRUE
     {Bool (true)}
 | FALSE
     {Bool (false)}

 | expr EQUAL expr
     {Eq ($1,$3)}
 | expr NEQ expr
     {Neq ($1,$3)}
 | expr LT expr
     {Lt ($1,$3)}
 | expr GT expr
     {Lt ($3,$1)}
 | expr LE expr
     {Le ($1,$3)}
 | expr GE expr
     {Le ($3,$1)}

 | expr PLUS expr
     {Add($1,$3)}
 | expr MINUS expr
     {Sub($1,$3)}
 | expr MUL expr
     {Mul($1,$3)}
 | expr DIV expr
     {Div($1,$3)}

 | LPAREN expr RPAREN
     {$2}
 | ID
     {Var $1}

 | IF expr THEN expr ELSE expr
     {If($2,$4,$6)}
 | NOT expr
     {Not $2}

 | expr OR expr
     {Or ($1,$3)}
 | expr AND expr
     {And ($1,$3)}
;
