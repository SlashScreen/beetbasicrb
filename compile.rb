$LOAD_PATH << '.'

require "beetbasic.kpeg.rb"

module BeetCompiler
    def BeetCompiler.compile(ast)
        ast.map {|node|}
    end
end
