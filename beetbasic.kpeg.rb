require 'kpeg/compiled_parser'

class BeetBasic < KPeg::CompiledParser


    attr_reader :ast


  # :stopdoc:

  module AST
    class Node; end
    class Block < Node
      def initialize(body)
        @body = body
      end
      attr_reader :body
    end
    class Branch < Node
      def initialize(expr)
        @expr = expr
      end
      attr_reader :expr
    end
  end
  module ASTConstruction
    def block(body)
      AST::Block.new(body)
    end
    def branch(expr)
      AST::Branch.new(expr)
    end
  end
  include ASTConstruction

  # period = "."
  def _period
    _tmp = match_string(".")
    set_failed_rule :_period unless _tmp
    return _tmp
  end

  # space = " "
  def _space
    _tmp = match_string(" ")
    set_failed_rule :_space unless _tmp
    return _tmp
  end

  # indent = ("    " | "\t")
  def _indent

    _save = self.pos
    while true # choice
      _tmp = match_string("    ")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\t")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_indent unless _tmp
    return _tmp
  end

  # newline = /(\r\n|\r|\n)/
  def _newline
    _tmp = scan(/\G(?-mix:(\r\n|\r|\n))/)
    set_failed_rule :_newline unless _tmp
    return _tmp
  end

  # bang = "!"
  def _bang
    _tmp = match_string("!")
    set_failed_rule :_bang unless _tmp
    return _tmp
  end

  # ALPHA = /[A-Za-z]/
  def _ALPHA
    _tmp = scan(/\G(?-mix:[A-Za-z])/)
    set_failed_rule :_ALPHA unless _tmp
    return _tmp
  end

  # DIGIT = /[0-9]/
  def _DIGIT
    _tmp = scan(/\G(?-mix:[0-9])/)
    set_failed_rule :_DIGIT unless _tmp
    return _tmp
  end

  # ident = ALPHA+
  def _ident
    _save = self.pos
    _tmp = apply(:_ALPHA)
    if _tmp
      while true
        _tmp = apply(:_ALPHA)
        break unless _tmp
      end
      _tmp = true
    else
      self.pos = _save
    end
    set_failed_rule :_ident unless _tmp
    return _tmp
  end

  # kw_if = "if"
  def _kw_if
    _tmp = match_string("if")
    set_failed_rule :_kw_if unless _tmp
    return _tmp
  end

  # kw_end = "end"
  def _kw_end
    _tmp = match_string("end")
    set_failed_rule :_kw_end unless _tmp
    return _tmp
  end

  # kw_fn = "fn"
  def _kw_fn
    _tmp = match_string("fn")
    set_failed_rule :_kw_fn unless _tmp
    return _tmp
  end

  # STMT = ident:i newline {i}
  def _STMT

    _save = self.pos
    while true # sequence
      _tmp = apply(:_ident)
      i = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_newline)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; i; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_STMT unless _tmp
    return _tmp
  end

  # EXPR = ident
  def _EXPR
    _tmp = apply(:_ident)
    set_failed_rule :_EXPR unless _tmp
    return _tmp
  end

  # BLOCK = (space | indent)* (IF:b {block(b)} | STMT+:b {block(b)})?
  def _BLOCK

    _save = self.pos
    while true # sequence
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_space)
          break if _tmp
          self.pos = _save2
          _tmp = apply(:_indent)
          break if _tmp
          self.pos = _save2
          break
        end # end choice

        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos

      _save4 = self.pos
      while true # choice

        _save5 = self.pos
        while true # sequence
          _tmp = apply(:_IF)
          b = @result
          unless _tmp
            self.pos = _save5
            break
          end
          @result = begin; block(b); end
          _tmp = true
          unless _tmp
            self.pos = _save5
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save4

        _save6 = self.pos
        while true # sequence
          _save7 = self.pos
          _ary = []
          _tmp = apply(:_STMT)
          if _tmp
            _ary << @result
            while true
              _tmp = apply(:_STMT)
              _ary << @result if _tmp
              break unless _tmp
            end
            _tmp = true
            @result = _ary
          else
            self.pos = _save7
          end
          b = @result
          unless _tmp
            self.pos = _save6
            break
          end
          @result = begin; block(b); end
          _tmp = true
          unless _tmp
            self.pos = _save6
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save4
        break
      end # end choice

      unless _tmp
        _tmp = true
        self.pos = _save3
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_BLOCK unless _tmp
    return _tmp
  end

  # IF = kw_if space* EXPR:e space* newline BLOCK*:body kw_end {branch(e)}
  def _IF

    _save = self.pos
    while true # sequence
      _tmp = apply(:_kw_if)
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_space)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_EXPR)
      e = @result
      unless _tmp
        self.pos = _save
        break
      end
      while true
        _tmp = apply(:_space)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_newline)
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true
        _tmp = apply(:_BLOCK)
        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      body = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_kw_end)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; branch(e); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_IF unless _tmp
    return _tmp
  end

  # root = STMT+:b {@ast = b}
  def _root

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _ary = []
      _tmp = apply(:_STMT)
      if _tmp
        _ary << @result
        while true
          _tmp = apply(:_STMT)
          _ary << @result if _tmp
          break unless _tmp
        end
        _tmp = true
        @result = _ary
      else
        self.pos = _save1
      end
      b = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; @ast = b; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_root unless _tmp
    return _tmp
  end

  Rules = {}
  Rules[:_period] = rule_info("period", "\".\"")
  Rules[:_space] = rule_info("space", "\" \"")
  Rules[:_indent] = rule_info("indent", "(\"    \" | \"\\t\")")
  Rules[:_newline] = rule_info("newline", "/(\\r\\n|\\r|\\n)/")
  Rules[:_bang] = rule_info("bang", "\"!\"")
  Rules[:_ALPHA] = rule_info("ALPHA", "/[A-Za-z]/")
  Rules[:_DIGIT] = rule_info("DIGIT", "/[0-9]/")
  Rules[:_ident] = rule_info("ident", "ALPHA+")
  Rules[:_kw_if] = rule_info("kw_if", "\"if\"")
  Rules[:_kw_end] = rule_info("kw_end", "\"end\"")
  Rules[:_kw_fn] = rule_info("kw_fn", "\"fn\"")
  Rules[:_STMT] = rule_info("STMT", "ident:i newline {i}")
  Rules[:_EXPR] = rule_info("EXPR", "ident")
  Rules[:_BLOCK] = rule_info("BLOCK", "(space | indent)* (IF:b {block(b)} | STMT+:b {block(b)})?")
  Rules[:_IF] = rule_info("IF", "kw_if space* EXPR:e space* newline BLOCK*:body kw_end {branch(e)}")
  Rules[:_root] = rule_info("root", "STMT+:b {@ast = b}")
  # :startdoc:
end
