class Ledger
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def add(arg)
    @balance += arg
  end
end

class Product
  def self.add_price_by_updating(ledger, price)
    ledger.add(price)
    puts "add_price_by_updating 안에서의 ledger 값: #{ledger.balance}"
  end
  def self.add_price_by_replacing(ledger, price)
    ledger = Ledger.new(ledger.balance + price)
    puts "add_price_by_replacing 안에서의 ledger 값: #{ledger.balance}"
  end
end

l1 = Ledger.new(0)
Product.add_price_by_updating(l1, 5)
puts "add_price_by_updating 실행 후의 l1 값: #{l1.balance}"

l2 = Ledger.new(0)
Product.add_price_by_replacing(l2, 5)
puts "add_price_by_replacing 실행 후의 l2 값: #{l2.balance}"
