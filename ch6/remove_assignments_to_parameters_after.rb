def discount(input_val, quantity, year_to_date)
  result = input_val
  if input_val > 50
    result -= 2
  end
end

def a_method(foo)
  foo.어떠한_방법으로_수정 # 문제없음
  foo = 다른_객체 # 온갖 문제 발생
end
