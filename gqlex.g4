grammar gqlex;

// Lexer rules
fragment NEGATIVE_SIGN
    : '-'
    ;
    
fragment NONZERO_DIGIT
    : [1-9]
    ;

fragment DIGIT
    : [0-9]
    ;

fragment LETTER
    : [a-zA-Z]
    ;

fragment NAME_START
    : LETTER
    | '_'
    ;

fragment NAME_CONTINUE
    : LETTER
    | '_'
    | DIGIT
    ;

SLASH: '/';
DOUBLE_SLASH: '//';
DOTS: '...';

RANGE_OPEN: '{';
RANGE_CLOSE: '}';
COLON: ':';

EQUALS: '=';
LBRACK: '[';
RBRACK: ']';
LPAREN: '(';
RPAREN: ')';

COND_EQ: '==';
COND_NE: '!=';
COND_GT: '>';
COND_GE: '>=';
COND_LT: '<';
COND_LE: '<=';
COND_AND: '&&';
COND_OR: '||';

WS: [ \t\r\n]+ -> skip;

POSITIVE_INT
    : NONZERO_DIGIT DIGIT*
    ;

NEGATIVE_INT
    : NEGATIVE_SIGN POSITIVE_INT
    ;

NAME
    : NAME_START NAME_CONTINUE*
    ;

// Parser rules
document
    : pathExpression EOF
    ;

pathExpression
    : rootPathExpression
    | rangePathExpression
    ;

rootPathExpression
    : (DOUBLE_SLASH | SLASH) (pathElement (SLASH pathElement)*)?
    ;

rangePathExpression
    : RANGE_OPEN (rangeStartIntValue? COLON rangeEndIntValue?) RANGE_CLOSE rootPathExpression
    ;

elementSelectionExpression
    : nameValue EQUALS nameValue
    ;

pathElement
    : nameValue (LBRACK elementSelectionExpression RBRACK)? (LPAREN conditionExpression RPAREN)?
    | DOTS
    ;

comparisonOperator
    : COND_EQ
    | COND_NE
    | COND_GT
    | COND_GE
    | COND_LT
    | COND_LE
    ;

conditionLogicalOperator
    : COND_AND
    | COND_OR
    ;

conditionExpression
    : nameValue comparisonOperator (nameValue | intValue)
    | conditionExpression conditionLogicalOperator conditionExpression 
    ;

nameValue
    : NAME
    ;

intValue
    : POSITIVE_INT | NEGATIVE_INT | '0'
    ;

rangeEndIntValue
    : POSITIVE_INT
    ;

rangeStartIntValue
    : POSITIVE_INT | '0'
    ;
