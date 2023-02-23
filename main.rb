# typed: true
$LOAD_PATH << '.'

require "lexer"
require "parser"
require "ast"
require "compile"

def prompt(p)
    print p
    gets.chomp
end

compiler = BeetBasic::Compiler.new

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
        puts compiler.compile(ast)
    rescue RLTK::NotInLanguage
        puts "Not in language"
    end
end
