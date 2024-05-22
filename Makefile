gen_dir = gen
lang = Java
package = com.intuit.oss.gqlex.parser

.PHONY: all clean install test_cases

all: install
	@echo "Generating code..."
	@mkdir -p $(gen_dir)
	@source gqlex/bin/activate; antlr4 -Dlanguage=$(lang) -o $(gen_dir) -visitor -package $(package) -lib $(gen_dir) gqlex.g4

install: requirements.txt
	@echo "Installing dependencies..."
	@python3 -m venv gqlex && source gqlex/bin/activate; python3 -m pip install -r requirements.txt

test_cases: install
	@echo "Generating test cases..."
	@mkdir -p tests/fuzzer/ tests/cases/
	@source gqlex/bin/activate; grammarinator-process gqlex.g4 -o tests/fuzzer/ --no-actions
	@source gqlex/bin/activate; grammarinator-generate gqlexGenerator.gqlexGenerator -r document -d 25 -n 10 -o tests/cases/test_%d.gql --sys-path tests/fuzzer/

clean:
	rm -rf $(gen_dir)/* tests/ gqlex/ gen/