# typed: strict
require 'rltk/ast'

module BeetBasic
    #Expressions
    class Expression < RLTK::ASTNode; end

    class Number < Expression
        value :value, Integer #* value is a method that takes a symbol and a type.
    end
    
    class Variable < Expression
        value :name, String
    end
    
    #Binops
    class Binary < Expression
        child :left, Expression #* child is a method that takes a symbol and a type. The lack of parenthesis is kiling me.
        child :right, Expression
    end

    class Add < Binary; end
    class Sub < Binary; end
    class Mul < Binary; end
    class Div < Binary; end
    class LT < Binary; end
    class GT < Binary; end
    class LTE < Binary; end
    class GTE < Binary; end

    #Function call
    class Call < Expression
        value :name, String
        child :args, [Expression] # takes in an array of expressions
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
