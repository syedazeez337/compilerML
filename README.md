# Lisp Interpreter in OCaml

This project guides you through building a small Lisp interpreter from scratch in OCaml. The repository is organized as a teaching tool: each component of the interpreter is introduced incrementally with clear, well-documented code and accompanying tests.

The repository currently includes a **lexer** that turns raw input into tokens and a **parser** that converts those tokens into an abstract syntax tree (AST). Future commits will add an evaluator and a REPL.

## Prerequisites

You will need OCaml, [dune](https://dune.build/), and [opam](https://opam.ocaml.org/) installed. The project uses `ounit2` for unit testing.

To install dependencies locally run:

```sh
opam install . --deps-only -y
```

## Building and Testing

Build everything with dune:

```sh
dune build
```

Run the automated tests:

```sh
dune runtest --display=short
```

All current tests exercise the lexer and parser.

## Project Layout

- `src/token.ml`, `src/token.mli` – definitions of the token types produced by the lexer.
- `src/lexer.ml`, `src/lexer.mli` – the tokenizer implementation.
- `src/ast.ml`, `src/ast.mli` – abstract syntax tree definitions.
- `src/parser.ml`, `src/parser.mli` – parser building the AST from tokens.
- `src/lexer_test.ml` – unit tests for the lexer using OUnit2.
- `src/parser_test.ml` – unit tests for the parser using OUnit2.
- `dune-project`, `lisp.opam` – build configuration files.

## Using the Lexer

You can experiment with the lexer in the OCaml toplevel after building the project. Start an OCaml session with dune:

```sh
dune utop src
```

Then tokenize an expression:

```ocaml
# Lexer.tokenize "(+ 1 2)";;
- : Token.t list = [LParen; Symbol "+"; Number 1.; Number 2.; RParen]
```

## Using the Parser

You can turn the list of tokens into an AST:

```ocaml
# let tokens = Lexer.tokenize "(+ 1 2)";;
# Parser.parse tokens;;
- : Ast.t list = [Ast.List [Ast.Symbol "+"; Ast.Number 1.; Ast.Number 2.]]
```

## Roadmap

The goal of the project is to arrive at a working Lisp interpreter supporting variables, functions, and a simple REPL. The steps will roughly be:

1. **Tokenizer** – completed.
2. **Parser** – completed.
3. **Evaluator** – evaluate expressions in an environment.
4. **REPL** – interactive read–eval–print loop.

Each stage will come with explanations and tests so you can follow along and expand the interpreter yourself.

