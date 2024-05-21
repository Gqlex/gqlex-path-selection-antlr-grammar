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
