package main

import (
	"fmt"
	"github.com/antlr4-go/antlr/v4"
	"gqlex-grammar/gen/antlr/parser"
	"os"
)

type TreeShapeListener struct {
	*parser.BasegqlexListener
}

func NewTreeShapeListener() *TreeShapeListener {
	return new(TreeShapeListener)
}

func (tsp *TreeShapeListener) EnterEveryRule(ctx antlr.ParserRuleContext) {
	fmt.Println(ctx.GetText())
}

func main() {
	input, _ := antlr.NewFileStream(os.Args[1])
	lexer := parser.NewgqlexLexer(input)
	stream := antlr.NewCommonTokenStream(lexer, 0)
	p := parser.NewgqlexParser(stream)
	p.AddErrorListener(antlr.NewDiagnosticErrorListener(true))
	tree := p.Document()
	antlr.ParseTreeWalkerDefault.Walk(NewTreeShapeListener(), tree)
}
