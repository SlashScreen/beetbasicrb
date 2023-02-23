$LOAD_PATH << '.'

require "lexer"
require "parser"
require "ast"

def prompt(p)
    print p
    gets.chomp
end

loop do
    line = prompt('BeetBasic ==> ')

    break if line == 'quit' || line == 'exit'

    begin
        ast = BeetBasic::Parser.parse(BeetBasic::Lexer.lex(line))
        case ast
        when BeetBasic::Expression then puts "parsed an expression"
        when BeetBasic::Prototype then puts "parsed a prototype"
        when BeetBasic::Function then puts "parsed a function"
        end
    rescue RLTK::NotInLanguage
        puts "Not in language"
    end
end
