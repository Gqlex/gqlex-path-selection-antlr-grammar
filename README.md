# gqlex-path-selection-antlr-grammar

This repository contains the ANTLR grammar definition for `gqlex`, a language designed to select nodes in GraphQL documents using path expressions.

## Contents

- `gqlex.g4`: The ANTLR grammar file defining the syntax for `gqlex`.
- `Makefile`: A Makefile to automate the process of generating code from the grammar.

## Getting Started

### Prerequisites

To use this project, you will need the following installed on your system:

- Make
- Python3 (for running the ANTLR tool)
- Golang (for testing the generated code, optional)
- `pip`

Use the following command to install the dependencies:

```bash
make install
```

### Generating Code

To generate the parser and lexer code from the grammar file, run the following command:

```bash
make
```

This will use the `Makefile` to invoke ANTLR and generate the necessary files (defaults to Java).

Supported variables:

- `lang`: The target language for the generated code (defaults to `Java`, supports ANTLR target languages, such as `Python3`, `Go`, `Cpp`, etc.).
- `gen_dir`: The output directory for the generated code (defaults to `gen`).
- `package`: The package name for the generated code (defaults to `com.intuit.oss.gqlex.parser`).

For example, to generate Python3 code, run the following command:

```bash
make lang=Python3 gen_dir=gen_python package=parser_python
```

### Grammar Overview

The `gqlex.g4` file defines the syntax for `gqlex`, including:

- Path expressions for navigating through GraphQL documents.
- Range expressions for selecting specific ranges of nodes.
- Conditions for filtering nodes based on various criteria.

## Testing

To generate the test cases for the grammar, run the following command:

```bash
make clean test_cases
```

You can also generate the test cases and run them in one step:

```bash
make test
```

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your changes.
