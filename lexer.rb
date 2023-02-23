# typed: false
require 'rltk/lexer'

module BeetBasic
    class Lexer < RLTK::Lexer
        rule(/\s/) #Discard spaces
        #Keywords
        rule(/if/) { :IF }
        rule(/var/) { :VAR }
        rule(/else/) { :ELSE }
        rule(/end/) { :END }
        rule(/fn/) { :FN }
        rule(/while/) { :WHILE }
        rule(/return/) { :RETURN }
        #Operators, delimiters
        rule(/=/) { :ASSIGN }
        rule(/\(/) { :LPAREN }
        rule(/\)/) { :RPAREN }
        rule(/\{/) { :LBRACE }
        rule(/\}/) { :RBRACE }
        rule(/\[/) { :LBRACKET }
        rule(/\]/) { :RBRACKET }
        rule(/,/) { :COMMA }
        rule(/;/) { :SEMI }
        rule(/\+/) { :ADD }
        rule(/-/) { :SUB }
        rule(/\*/) { :MUL }
        rule(/\//) { :DIV }
        rule(/%/) { :MOD }
        rule(/</) { :LT }
        rule(/>/) { :GT }
        rule(/<=/) { :LTE }
        rule(/>=/) { :GTE }
        rule(/==/) { :EQ }
        rule(/!=/) { :NEQ }
        rule(/&&/) { :AND }
        rule(/\|\|/) { :OR }
        rule(/!/) { :NOT } #TODO: bang operator
        #Identifier
        rule(/[A-Za-z][A-Za-z0-9]*/) { |t| [:IDENT, t] } #* Note: To pass in values, use an array.
        #Numeric rules
        rule(/\d+/) { |t| [:NUM, t.to_i] } #Integer
        # rule(/\d+\.\d+/) { |t| [:NUM, t.to_f] } #Float #TODO: Add floats to uxn. But that's later.
        #Comment rules
        rule(/--/) { push_state :COMMENT } #* Sets the lexer into comment mode
        rule(/(\r\n|\r|\n)/) { pop_state } #* Pops the lexer out of comment mode
        rule(/./, :COMMENT) { } #* Ignores all characters in comment mode
    end
end