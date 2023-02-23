$LOAD_PATH << '.'

require "beetbasic.kpeg.rb"

parser = BeetBasic.new("
if foo
    blah
end
")

puts parser.parse
puts parser.ast
