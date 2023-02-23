require 'rltk/parser'

module BeetBasic
    class Parser < RLTK::Parser
        production(:input, 'statement SEMI') { |s, _| s }

        production(:statement) do
            clause("expr") {|e| e}
            clause("proto") {|pr| pr}
            clause("fn") {|f| f}
        end

        production(:expr) do
            #Parse expressions in parenthesis as an expression
            clause("LPAREN expr RPAREN") {|_, e, _| e}
            #Parse literals
            clause("NUM") {|n| Number.new(n)}
            clause("IDENT") {|i| Variable.new(i)}
            #Parse binary operations
            clause("expr ADD expr") {|e0, _, e1| Add.new(e0, e1)}
            clause("expr SUB expr") {|e0, _, e1| Sub.new(e0, e1)}
            clause("expr MUL expr") {|e0, _, e1| Mul.new(e0, e1)}
            clause("expr DIV expr") {|e0, _, e1| Div.new(e0, e1)}
            clause("expr MOD expr") {|e0, _, e1| Mod.new(e0, e1)}
            clause("expr LT expr") {|e0, _, e1| LT.new(e0, e1)}
            clause("expr GT expr") {|e0, _, e1| GT.new(e0, e1)}
            clause("expr LTE expr") {|e0, _, e1| LTE.new(e0, e1)}
            clause("expr GTE expr") {|e0, _, e1| GTE.new(e0, e1)}
            #Function call
            clause("IDENT LPAREN args RPAREN") {|i, _, args, _| Call.new(i, args)}

        end
        #Arguments
        production(:args) do
            clause("") { [] } #no arguments
            clause("arg_list") { |a| a }
        end

        production(:arg_list) do
            clause("expr") { |e| [e] }
            clause("expr COMMA arg_list") { |e, _, a| [e] + a } #recursive
        end
        #Functions
        production(:proto, "FN p_body") { |_, pr| pr }
        production(:fn, "proto expr") { |pr, e| Function.new(pr, e) }
        production(:p_body, "IDENT LPAREN arg_defs RPAREN") { |name, _, arg_names, _| Prototype.new(name, arg_names) }

        production(:arg_defs) do
            clause("") { [] } #no arguments
            clause("arg_def_list") { |a| a }
        end

        production(:arg_def_list) do
            clause("IDENT") { |i| [i] }
            clause("IDENT COMMA arg_def_list") { |i, _, a| [i] + a } #recursive
        end

        finalize({:use => 'bbparser.tbl'})
    end
end
