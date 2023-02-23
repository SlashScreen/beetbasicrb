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
        "\##{n.value}"
      in BeetBasic::Variable => v
        puts "Compiling a variable"
        "#{v.name}; LDA"
      in BeetBasic::Add => a
        puts "Compiling an addition"
        lhs = compile a.left
        rhs = compile a.right
        "#{lhs} #{rhs} ADD"
      in BeetBasic::Sub => s
        puts "Compiling a subtraction"
        lhs = compile a.left
        rhs = compile a.right
        "#{lhs} #{rhs} SUB"
      in BeetBasic::Mul => m
        puts "Compiling a multiplication"
        "todo"
      in BeetBasic::Div => d
        puts "Compiling a division"
        "todo"
      in BeetBasic::LT => l
        puts "Compiling a less than"
        "todo"
      in BeetBasic::GT => g
        puts "Compiling a greater than"
        "todo"
      in BeetBasic::LTE => l
        puts "Compiling a less than or equal to"
        "todo"
      in BeetBasic::GTE => g
        puts "Compiling a greater than or equal to"
        "todo"
      in BeetBasic::Call => c
        puts "Compiling a function call"
        "todo"
      in BeetBasic::Prototype => pr
        puts "Compiling a prototype"
        "todo"
      in BeetBasic::Function => f
        puts "Compiling a function"
        "todo"
      end
    end
  end
end
