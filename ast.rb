# typed: strict
require 'rltk/ast'

module BeetBasic
    #Expressions
    class Expression < RLTK::ASTNode
        def compile
            "TODO"
        end
    end

    class Number < Expression
        value :value, Integer #* value is a method that takes a symbol and a type.
        def compile
            "##{value}"
        end
        #cmp {@value.to_s}
    end

    class Variable < Expression
        value :name, String
        def compile
            "#{name}; LDA"
        end
    end

    #Binops
    class Binary < Expression
        child :left, Expression #* child is a method that takes a symbol and a type. The lack of parenthesis is kiling me.
        child :right, Expression
    end

    class Add < Binary
        def compile
            lhs = @left.compile
            rhs = @right.compile
            "#{lhs} #{rhs} ADD"
        end
    end
    class Sub < Binary
        def compile
            lhs = @left.compile
            rhs = @right.compile
            "#{lhs} #{rhs} SUB"
        end
    end
    class Mul < Binary
        def compile
            lhs = @left.compile
            rhs = @right.compile
            "#{lhs} #{rhs} MUL"
        end
    end
    class Div < Binary
        def compile
            lhs = @left.compile
            rhs = @right.compile
            "#{lhs} #{rhs} DIV"
        end
    end
    class LT < Binary
        def compile
            lhs = @left.compile
            rhs = @right.compile
            "#{lhs} #{rhs} LTH"
        end
    end
    class GT < Binary
        def compile
            lhs = @left.compile
            rhs = @right.compile
            "#{lhs} #{rhs} GTH"
        end
    end

    class LTE < Binary
        def compile
            lhs = @left.compile
            rhs = @right.compile
            "#{lhs} #{rhs} LTH #{lhs} #{rhs} EQU ORA"
        end
    end
    class GTE < Binary
        def compile
            lhs = @left.compile
            rhs = @right.compile
            "#{lhs} #{rhs} GTH #{lhs} #{rhs} EQU ORA"
        end
    end

    #Function call
    class Call < Expression
        value :name, String
        child :args, [Expression] # takes in an array of expressions
        def compile
            fn_args = @args.map { |arg| arg.compile }.join(" ")
            "#{args} @#{name} JSR2"
        end
    end

    #Function signature
    class Prototype < RLTK::ASTNode
        value :name, String
        value :arg_names, [String]
    end

    class Function < RLTK::ASTNode
        child :proto, Prototype
        child :body, Expression
    end
end
