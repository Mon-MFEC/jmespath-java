grammar JmesPath;

import JSON;

query : expression EOF ;

expression
  : expression '.' (IDENTIFIER | multi_select_list | multi_select_hash | function_expression | '*')
  | expression bracket_specifier
  | bracket_specifier
  | expression '||' expression
  | IDENTIFIER
  | expression '&&' expression
  | expression COMPARATOR expression
  | not_expression
  | paren_expression
  | '*'
  | multi_select_list
  | multi_select_hash
  | literal
  | function_expression
  | expression '|' expression
  | RAW_STRING
  | current_node
  ;

not_expression : '!' expression ;

paren_expression : '(' expression ')' ;

multi_select_list : '[' expression (',' expression)* ']' ;

multi_select_hash : '{' keyval_expr (',' keyval_expr)* '}' ;

keyval_expr : IDENTIFIER ':' expression ;

bracket_specifier
  : '[' (NUMBER | '*' | SLICE_EXPRESSION) ']'
  | '[]'
  | '[' '?' expression ']'
  ;

SLICE_EXPRESSION : NUMBER? ':' NUMBER? (':' NUMBER?)? ;

COMPARATOR
  : '<'
  | '<='
  | '=='
  | '>='
  | '>'
  | '!='
  ;

// TODO: should be UNQUOTED_STRING and not IDENTIFIER, but that doesn't work
function_expression : IDENTIFIER (no_args | one_or_more_args) ;

no_args : '(' ')' ;

one_or_more_args : '(' function_arg (',' function_arg)* ')' ;

function_arg
  : expression
  | expression_type
  ;

current_node : '@' ;

expression_type : '&' expression ;

RAW_STRING : '\'' (ESCAPE '\'' | ~['\\])* '\'' ;

literal : '`' value '`' ;

NUMBER : '-'? DIGIT+ ;

fragment ESCAPE : '\\' ;

DIGIT : [0-9] ;

LETTER : [a-zA-Z] ;

IDENTIFIER
  : UNQUOTED_STRING
  | QUOTED_STRING
  ;

fragment UNQUOTED_STRING : LETTER (LETTER | DIGIT | '_')* ;

fragment QUOTED_STRING : '"' (STRING_ESCAPE | ~["\\])* '"' ;

fragment STRING_ESCAPE : ESCAPE (["\\/bfnrt] | 'u' HEXDIGIT HEXDIGIT HEXDIGIT HEXDIGIT) ;

fragment HEXDIGIT : DIGIT | [a-fA-F] ;

WS : [ \t\r\n]+ -> skip ;
