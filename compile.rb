# typed: true
$LOAD_PATH << '.'

module BeetBasic
  class Compiler
    attr_accessor :symbol_table
    def initialize
      @st = {}
    end

    def compile(node)
      case node
      in BeetBasic::Number => n
        puts "Compiling a number"
      in BeetBasic::Variable => v
        puts "Compiling a variable"
      in BeetBasic::Add => a
        puts "Compiling an addition"
        compile a.left
        compile a.right
      in BeetBasic::Sub => s
        puts "Compiling a subtraction"
      in BeetBasic::Mul => m
        puts "Compiling a multiplication"
      in BeetBasic::Div => d
        puts "Compiling a division"
      in BeetBasic::LT => l
        puts "Compiling a less than"
      in BeetBasic::GT => g
        puts "Compiling a greater than"
      in BeetBasic::LTE => l
        puts "Compiling a less than or equal to"
      in BeetBasic::GTE => g
        puts "Compiling a greater than or equal to"
      in BeetBasic::Call => c
        puts "Compiling a function call"
      in BeetBasic::Prototype => pr
        puts "Compiling a prototype"
      in BeetBasic::Function => f
        puts "Compiling a function"
      end
    end
  end
end
