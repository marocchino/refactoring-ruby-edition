def product_count_item(search_criteria=nil)
  criteria = search_criteria | @search_criteria
  ProductCountItem.find_all_by_criteria(criteria)
end

def product_count_item(search_criteria)
  ProductCountItem.find_all_by_criteria(search_criteria)
end
