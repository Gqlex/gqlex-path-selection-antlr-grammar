gen_dir = gen
lang = Java

.PHONY: all clean install

all:
	@echo "Generating code..."
	@mkdir -p $(gen_dir)
	@antlr4 -Dlanguage=$(lang) -o $(gen_dir) -visitor -lib $(gen_dir) gqlex.g4

clean:
	rm -rf $(gen_dir)/*

install:
	@echo "Installing dependencies..."
	@pip install antlr4-tools

test_cases:
	@echo "Generating test cases..."
	@grammarinator-process gqlex.g4 -o tests/fuzzer/ --no-actions
	@grammarinator-generate gqlexGenerator.gqlexGenerator -r document -d 25 -n 100 -o tests/cases/test_%d.gql --sys-path tests/fuzzer/
