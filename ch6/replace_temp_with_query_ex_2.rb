def price
  a_base_price =  base_price
  if (base_price > 1000)
    discount_factor = 0.95
  else
    discount_factor = 0.85
  end
  a_base_price * discount_factor
end

def base_price
  @quantity + @item_price
end

