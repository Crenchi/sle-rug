module Syntax

extend lang::std::Layout;
extend lang::std::Id;

/*
 * Concrete syntax of QL
 */

start syntax Form 
  = "form" Id name "{" Question* questions "}"; 

// TODO: question, computed question, block, if-then-else, if-then
syntax Question 
  = Id identifier ":" Type ";"
  | Id identifier ":" Type "=" Expr ";"
  | "if" Expr "then" Block "else" Block
  | "if" Expr "then" Block
  | "{" Question* "}"
  ;

syntax Block
  = "{" Question* "}"
  ;

// TODO: +, -, *, /, &&, ||, !, >, <, <=, >=, ==, !=, literals (bool, int, str)
// Think about disambiguation using priorities and associativity
// and use C/Java style precedence rules (look it up on the internet)
syntax Expr //What is Id? the string?
  = Id
  | Int
  | Bool
  | Str
  | MathExpr
  | LogicalExpr
  | right "!" Expr
  ;

syntax MathExpr           //This solves the priority issue
  = left  ( Expr "*" Expr
          | Expr "/" Expr
          )
  > left  ( Expr "+" Expr
          | Expr "-" Expr
          )
  ;

syntax LogicalExpr //TODO figure out how to do without the \ before the logic operators and check priorities maybe
  = Expr "==" Expr
  | Expr "!=" Expr
  | Expr "\>" Expr
  | Expr '\<' Expr
  | Expr "\>=" Expr
  | Expr "\<=" Expr
  | Expr "&&" Expr
  | Expr "||" Expr
  ;

syntax Type 
  = "boolean"
  | "integer"
  | "string"
  ;


lexical Str = "\'" ([^\'])* "\'";   //Checks 'String' currently, switched to ' instead of "" for testing

lexical Int = "-"?[0-9]+;           //optional -, and at least one number, should it be made for valid ints? g.e should 05 be valid or -0?

lexical Bool                        //Boolean
  = "true"
  | "false"
  ;



