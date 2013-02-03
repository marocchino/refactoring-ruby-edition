def print_owing(previous_amount)
  outstanding = previous_amount * 1.2

  print_banner

  @orders.each do |order|
    outstanding += order.amount
  end

  print_detail(outstanding)
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

