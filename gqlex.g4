grammar gqlex;

// Lexer rules
NODE: '/';
ALL: '//';
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

INT: [0-9]+;
VALUE: [a-zA-Z_]+;

// Parser rules
document
    : pathExpression EOF
    ;

pathExpression
    : rootPathExpression
    | rangePathExpression
    ;

rootPathExpression
    : (ALL | NODE) (pathElement (NODE pathElement)*)+
    ;

rangePathExpression
    : RANGE_OPEN (INT? COLON INT?) RANGE_CLOSE rootPathExpression
    ;

elementSelectionExpression
    : lValue EQUALS rValue
    ;

pathElement
    : lValue (LBRACK elementSelectionExpression RBRACK)? (LPAREN conditionExpression RPAREN)?
    | DOTS
    ;

conditionOperator
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
    : lValue conditionOperator rValue (conditionLogicalOperator conditionExpression)?
    ;

lValue
    : VALUE
    ;

rValue
    : (INT | VALUE)+
    ;