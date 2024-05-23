gen_dir = gen
lang = Java
package = com.intuit.oss.gqlex.parser

.PHONY: all clean install test_cases

all: install
	@echo "Generating code..."
	@mkdir -p $(gen_dir)
	@source gqlex/bin/activate; antlr4 -Dlanguage=$(lang) -o $(gen_dir) -package $(package) -lib $(gen_dir) gqlex.g4

install: requirements.txt
	@echo "Installing dependencies..."
	@python3 -m venv gqlex && source gqlex/bin/activate; python3 -m pip install -r requirements.txt

test_cases: install
	@echo "Generating test cases..."
	@mkdir -p tests/fuzzer/ tests/cases/
	@source gqlex/bin/activate; \
		grammarinator-process gqlex.g4 -r document -o tests/fuzzer/ --no-actions; \
		grammarinator-generate gqlexGenerator.gqlexGenerator -r document -d 25 -n 10 -o tests/cases/test_%d.gql --sys-path tests/fuzzer/
	@echo "Test cases generated in tests/cases/"

test: clean test_cases
	@echo "Running tests..."
	@$(MAKE) lang=Go gen_dir=gen/antlr/parser package=parser
	@for i in {0..9}; do echo "Running for test_$$i.gql";go run main.go tests/cases/test_$$i.gql;echo ""; done

clean:
	rm -rf $(gen_dir)/ tests/ gqlex/ gen/