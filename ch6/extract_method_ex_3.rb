def print_owing
  print_banner
  outstanding = calculate_outstanding
  print_detail(outstanding)
end

def calculate_outstanding
  outstanding = 0.0
  @orders.each do |order|
    outstanding += order.amount
  end
  outstanding
end

def print_banner
  puts "***************************"
  puts "******** 고객외상 *********"
  puts "***************************"
end

def print_detail(outstanding)
  puts "name : #{@name}"
  puts "amount : #{outstanding}"
end
