def print_owing(previous_amount)
  outstanding = previous_amount * 1.2

  print_banner

  outstanding = calculate_outstanding(outstanding)
  print_detail(outstanding)
end

def calculate_outstanding(outstanding)
  @order.inject(outstanding) { |total, order| total + order.amount }
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


