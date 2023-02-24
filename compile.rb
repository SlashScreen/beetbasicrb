# typed: true
$LOAD_PATH << '.'

module BeetBasic
  class Compiler
    attr_accessor :symbol_table
    def initialize
      @st = {}
    end

    def compile(node)
      node.compile
    end
  end
end
