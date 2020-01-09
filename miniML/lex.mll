{
  open Parser
  exception Eof
}

(* 数字 *)
let NUM = ['-']?(['1'-'9']['0'-'9']*|"0")

rule token = parse

(* 识别保留字 *)
| "if"          {IF}
| "then"        {THEN}
| "else"        {ELSE}
| "let"         {LET}

(* 识别数字和标识符 *)
| NUM           {INT(int_of_string(Lexing.lexeme lexbuf))}
| ['A'-'Z' 'a'-'z' '_']['A'-'Z' 'a'-'z' '_' '0'-'9']* {ID(Lexing.lexeme lexbuf)}

(* 识别空格与换行符 *)
| [' ' '\t']    {token lexbuf}
| ['\n']        {EOL}

(* 识别算数运算符 *)
| '+'           {PLUS}
| '*'           {MUL}
| '/'           {DIV}
| '-'           {MINUS}

(* 识别括号 *)
| '('           {LPAREN}
| ')'           {RPAREN}

(* 识别Ture和False*)
| "true"        {TRUE}
| "false"       {FALSE}

(* 识别关系运算符 *)
| "<="          {LE}
| ">="          {GE}
| ">"           {GT}
| "<"           {LT}
| "<>"          {NEQ}
| "="           {EQUAL}

(* 布尔运算符*)
| "not"         {NOT}
| "||"          {OR}
| "&&"          {AND}

(* 识别输入末尾 *)
| eof         {raise Eof}
