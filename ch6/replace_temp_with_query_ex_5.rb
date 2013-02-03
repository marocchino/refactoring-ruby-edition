def price
  base_price * discount_factor
end

def base_price
  @quantity + @item_price
end

def discount_factor
  base_price > 1000 ? 0.95 : 0.85
end
