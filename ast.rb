# typed: strict
require 'rltk/ast'

module BeetBasic
    #Expressions
    class Expression < RLTK::ASTNode
        def compile
            "( Blank expression )"
        end
    end

    class Number < Expression
        value :value, Integer #* value is a method that takes a symbol and a type.
        #cmp {@value.to_s}
        def compile
            "##{value}"
        end
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

    #Branch
    class If < Expression
        child :cond, Expression
        child :th, Expression
        child :el, Expression
        def compile
            cond = @cond.compile
            if @el.nil?
                thc = @th.compile #hehe thc
                puts "#{th.class} #{thc}"
                "#{cond} branch_true, JCN branch_false, JMP &branch_true #{thc} &branch_false"
            else
                thc = @th.compile
                elc = @el.compile
                puts "#{th.class} #{thc}"
                puts "#{el.class} #{elc}"
                "#{cond} branch_true, JCN #{elc} &branch_true #{thc}"
            end
        end
    end

    #for loop
    class For < Expression
        value :var, String
        child :init, Expression
        child :cond, Expression
        child :step, Expression
        child :body, Expression

        def compile
            init = @init.compile
            cond = @cond.compile
            step = @step.compile
            body = @body.compile
            "#{init} #{cond} &loop #{body} #{step} NEQ loop, JMP2r"
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
        def compile
            "@#{name}"
        end
    end

    class Function < RLTK::ASTNode
        child :proto, Prototype
        child :body, Expression
        def compile
            "#{proto.compile} #{body.compile} JMP2r"
        end
    end
end
