require 'pp'

$LOAD_PATH << '.'

require "beetbasic.kpeg.rb"

parser = BeetBasic.new("
if foo
    blah
end
")

puts parser.parse
PP.pp parser.ast, $>, 79