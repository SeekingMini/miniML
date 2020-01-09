main:
	ocamlc -c syntax.ml
	ocamllex  lex.mll       
	ocamlyacc parser.mly     
	ocamlc -c parser.mli
	ocamlc -c lex.ml
	ocamlc -c parser.ml
	ocamlc -c type.ml
	ocamlc -c main.ml
	ocamlc -o mml syntax.cmo lex.cmo parser.cmo type.cmo main.cmo
	mv mml ../build
clean:
	rm *.cmo
	rm *.cmi
	rm lex.ml
	rm parser.ml
	rm parser.mli
