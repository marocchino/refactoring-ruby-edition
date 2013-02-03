def print_owing
  outstanding = 0.0

  puts "***************************"
  puts "******** 고객외상 *********"
  puts "***************************"

  @orders.each do |order|
    outstanding += order.amount
  end

  puts "name : #{@name}"
  puts "amount : #{outstanding}"
end
