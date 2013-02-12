def price
  # 결재액(price) = 총 구매액(base price) - 대량 구매 확인(quantity price) + 배송료(shipping)
  base_price = @quantity * @item_price
  return base_price -
    [0, @quantity - 500].max * @item_price * 0.05 +
    [@quantity * @item_price * 0.1, 100.0].min
end
