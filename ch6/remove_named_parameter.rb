IsbnSearch.new(isbn: "0201485672")

IsbnSearch.new("0201485672")


class Books
  def self.find(hash={})
    hash[:conditions] ||= ""
    hash[:joins] ||= []
    sql = ["SELECT * FROM books"]
    hash[:joins].each do  |join_table|
      sql << "LEFT OUTER JOIN #{join_table} ON"
      sql << "books.#{join_table.to_s.chap}_id"
      sql << "= #{join_table}.id"
    end
    sql << "WHERE #{hash[:conditions]}" unless hash[:conditions].empty?
    sql << "LIMIT 1" if hash[:selector] == :first

    connection.find(sql.join(" "))
  end
end

Books.find
Books.find(selector: :all, conditions: "authors.name = 'Jenny James", joins: :authors)
Books.find(selector: :first, conditions: "authors.name = 'Jenny James'", joins: :authors)


class Books
  def self.find(selector, hash={})
    hash[:conditions] ||= ""
    hash[:joins] ||= []
    sql = ["SELECT * FROM books"]
    hash[:joins].each do  |join_table|
      sql << "LEFT OUTER JOIN #{join_table} ON"
      sql << "books.#{join_table.to_s.chap}_id"
      sql << "= #{join_table}.id"
    end
    sql << "WHERE #{hash[:conditions]}" unless hash[:conditions].empty?
    sql << "LIMIT 1" if selector == :first

    connection.find(sql.join(" "))
  end
end

Books.find(:all)
Books.find(:all, conditions: "authors.name = 'Jenny James", joins: :authors)
Books.find(:first, conditions: "authors.name = 'Jenny James'", joins: :authors)
