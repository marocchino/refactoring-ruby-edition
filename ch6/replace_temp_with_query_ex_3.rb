def price
  if (base_price > 1000)
    discount_factor = 0.95
  else
    discount_factor = 0.85
  end
  base_price * discount_factor
end

def base_price
  @quantity + @item_price
end
