$LOAD_PATH << '.'

require "lexer"
require "parser"
require "ast"

loop do
    line = ask('BeetBasic ==> ')

    break if line == 'quit' || line == 'exit'

    begin
        ast = BeetBasic::Parser.parse(BeetBasic::Lexer.lex(line))
        case ast
        when Expression then puts "parsed an expression"
        when Prototype then puts "parsed a prototype"
        when Function then puts "parsed a function"
        end
    rescue RLTK::NotInLanguage
        puts "Not in language"
    end
end
