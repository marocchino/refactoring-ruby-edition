# before
class Decorator
  def initialize(subject)
    @subject = subject
  end

  def method_missing(sym, *args, &block)
    @subject.send(sym, *args, &block)
  end
end


# after
class Decorator
  def initialize(subject)
    subject.pubilc_methods(false).each do |method|
      (class << self; self; end).class_eval do
        define_method method do |*args|
          sbject.send method, *args
        end
      end
    end
  end
end

# ex before
class Person
  attr_accessor :name, :age

  def method_missing(sym, *args, &block)
    empty?(sym.to_s.sub(/^empty_/, "").chomp("?"))
  end

  def empty?(sym)
    self.send(sym).nil?
  end
end

# ex after
class Person
  def self.attrs_with_empty_predicate(*args)
    attr_accessor(*args)
    args.each do |attr|
      define_method "empty_#{attr}?" do
        self.send(sym).nil?
      end
    end
  end

  attrs_with_empty_predicate :name, :age
end


# mine
class Person
  attr_accessor :name, :age

  [:name, :age].each do |attr|
    define_method "empty_#{attr}?" do
      empty?(attr)
    end
  end

  def empty?(sym)
    self.send(sym).nil?
  end
end
