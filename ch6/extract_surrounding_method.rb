def charge(amount, credit_card_number)
  connection = CreditCardServer.connect(..)
  connection.send(amount, credit_card_number)
rescue IOError => e
  Logger.log "주문 #{@order_number}의 내역을 서버에 전달하지 못했습니다. #{e}"
ensure
  connection.close
end


def charge(amount, credit_card_number)
  connect do |connection|
    connection.send(amount, credit_card_number)
  end
end

def connect
  connection = CreditCardServer.connect(..)
  yield connection
rescue IOError => e
  Logger.log "주문 #{@order_number}의 내역을 서버에 전달하지 못했습니다. #{e}"
ensure
  connection.close
end



class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death=nil, mother=nil)
    @name, @date_of_birth, @date_of_death, @mother = name, date_of_birth, date_of_death, mother
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  def number_of_living_descendants
    children.inject(0) do |count, child|
      count += 1 if child.alive?
      count + child.number_of_living_descendants
    end
  end

  def number_of_living_descendants_named(name)
    children.inject(0) do |count, child|
      count += 1 if child.name == name
      count + child.number_of_living_descendants_named(name)
    end
  end

  def alive?
    @date_of_death.nil?
  end
end

class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death=nil, mother=nil)
    @name, @date_of_birth, @date_of_death, @mother = name, date_of_birth, date_of_death, mother
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  def number_of_living_descendants
    children.inject(0) do |count, child|
      count += 1 if child.alive?
      count + child.number_of_living_descendants
    end
  end

  def number_of_living_descendants_named(name)
    count_descendants_matching(name)
  end

  def alive?
    @date_of_death.nil?
  end

  protected
  def count_descendants_matching(name)
    children.inject(0) do |count, child|
      count += 1 if child.name == name
      count + child.count_descendants_matching(name)
    end
  end
end

class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death=nil, mother=nil)
    @name, @date_of_birth, @date_of_death, @mother = name, date_of_birth, date_of_death, mother
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  def number_of_living_descendants
    count_descendants_matching(&:alive?)
  end

  def number_of_living_descendants_named(name)
    count_descendants_matching do |child|
      child.name == name
    end
  end

  def alive?
    @date_of_death.nil?
  end

  protected
  def count_descendants_matching(&block)
    children.inject(0) do |count, child|
      count += 1 if yield child
      count + child.count_descendants_matching(&block)
    end
  end
end
