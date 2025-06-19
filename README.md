# Lisp Interpreter in OCaml

This project guides you through building a small Lisp interpreter from scratch in OCaml. The repository is organized as a teaching tool: each component of the interpreter is introduced incrementally with clear, well-documented code and accompanying tests.

At the moment the interpreter contains only the **lexer** which turns raw input into a sequence of tokens. Future commits will add a parser, evaluator, and a REPL.

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

All current tests exercise the lexer.

## Project Layout

- `src/token.ml`, `src/token.mli` – definitions of the token types produced by the lexer.
- `src/lexer.ml`, `src/lexer.mli` – the tokenizer implementation.
- `src/lexer_test.ml` – unit tests for the lexer using OUnit2.
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

## Roadmap

The goal of the project is to arrive at a working Lisp interpreter supporting variables, functions, and a simple REPL. The steps will roughly be:

1. **Tokenizer** – completed.
2. **Parser** – build an AST from the tokens.
3. **Evaluator** – evaluate expressions in an environment.
4. **REPL** – interactive read–eval–print loop.

Each stage will come with explanations and tests so you can follow along and expand the interpreter yourself.

