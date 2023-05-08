# frozen_string_literal: true
require_relative "../compile.rb"
require_relative "../lexer.rb"
require_relative "../parser.rb"
require_relative "../ast.rb"

describe BeetBasic::Compiler do
  describe "Compile addition" do
	it "xill compile adding of two numbers" do
	  expect(BeetBasic::Add.new(BeetBasic::Number.new(1), BeetBasic::Number.new(2)).compile).to eq("#1 #2 ADD")
	end
  end
end
