miniML
------------
mml语言解释器

#### 项目介绍
mml语言（miniML的简称）是Ocaml语言的一个非常小的子集，仅仅包含了Ocaml中的一小部分基本功能。本项目可以在命令行直接运行，类似于脚本语言的解释器。

##### 背景
本学期修了《编译原理》这门课，这门课的课程设计要求实现C-Minus语言，于是我灵光一现——使用Ocaml来实现一个Ocaml的子集。正好Ocaml提供`ocamllex`、`ocamlyacc`等工具，我们可以非常方便地构造词法分析器和语法分析器。

##### mml语言
1. 词法
- 关键字：`if`、`then`、`else`、`let`、`true`、`false`、`not`
- 专用符号：`+`、`-`、`*`、`/`、`(`、`)`、`>`、`<`、`>=`、`<=`、`=`、`<>`、`||`、`&&`
- 整数
- 标识符
2. 语法和语义
具有基本的变量赋值、算数运算等功能。具体文法采用BNF范式书写，具体如下：
```
main ->   ε EOL
        | expr EOL 
        | LET ID EQUAL expr EOL
expr ->   INT
	    | TRUE
	    | FALSE
	    | expr EQUAL expr
	    | expr NEQ expr
	    | expr LT expr
	    | expr GT expr
	    | expr LE expr
	    | expr GE expr
	    | expr PLUS expr
	    | expr MINUS expr
	    | expr MUL expr
	    | expr DIV expr
	    | LPAREN expr RPAREN
	    | ID
	    | IF expr THEN expr ELSE expr
	    | NOT expr
	    | expr OR expr
	    | expr AND expr 
```

#### 项目架构
```
miniML |—————— miniML 源代码目录
				 |—————— lex.mml 词法分析器
				 |—————— parser.mly 语法分析器
				 |—————— syntax.ml 语法树生成器
				 |—————— type.ml 类型检查器
				 |—————— main.ml 程序入口文件兼语义分析器
			     |—————— Makefile 工程脚本文件
	   |—————— build 目标文件目录
			   	 |—————— mml 目标文件
	   |—————— Makefile 工程脚本文件
	   |—————— README.md 说明文档
```

#### 使用方法
本项目在macOS系统下进行开发，在Linux系统下测试通过。所有操作应当在项目根目录进行，否则会出现意外错误！
- 编译项目
```
make
```
- 运行mml解释器
```
make run
```
- 清除文件
```
make clean
```

#### 项目测试
由于mml是解释语言，所以所有测试直接在交互界面进行。
- 测试用例1
![1](./img/test-sample-1.png)
- 测试用例2
![2](./img/test-sample-2.png)