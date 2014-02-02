class SearchCriteria
  attr_accessor :author_id, :publisher_id, :isbn
  def initialize(author_id, publisher_id, isbn)
    @author_id = author_id
    @publisher_id = publisher_id
    @isbn = isbn
  end
end

SearchCriteria.new(5, 8, "0201485672")


class SearchCriteria
  def initialize(hash)
    @author_id = hash[:author_id]
    @publisher_id = hash[:publisher_id]
    @isbn = hash[:isbn]
  end
end

SearchCriteria.new(author_id: 5, publisher_id: 8, isbn: "0201485672")


module HashInitializer
  def hash_initializer(*attribute_names)
    define_method(:initialize) do |*args|
      data = args.first || {}
      data.symbolize_keys!
      attribute_names.each do |attribute_name|
        instance_variable_set "@#{attribute_name}", data[attribute_name]
      end
    end
  end
end

Class.send :include, HashInitializer

class SearchCriteria
  hash_initializer :author_id, :publisher_id, :isbn
end

SearchCriteria.new(author_id: 5, publisher_id: 8, isbn: "0201485672")
# see http://chriszetter.com/blog/2012/11/02/keyword-arguments-in-ruby-2-dot-0/


class Books
  def self.find(selector, conditions="", *joins)
    sql = ["SELECT * FROM books"]
    joins.each do  |join_table|
      sql << "LEFT OUTER JOIN #{join_table} ON"
      sql << "books.#{join_table.to_s.chap}_id"
      sql << "= #{join_table}.id"
    end
    sql << "WHERE #{conditions}" unless conditions.empty?
    sql << "LIMIT 1" if selector == :first

    connection.find(sql.join(""))
  end
end

Books.find(:all)
Books.find(:all, "title LIKE '%Voodoo Economics'")
Books.find(:all, "authors.name = 'Jenny James", :authors)
Books.find(:first, "authors.name = 'Jenny James'", :authors)


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
Books.find(:all, conditions: "title LIKE '%Voodoo Economics'")
Books.find(:all, conditions: "authors.name = 'Jenny James", joins: [:authors])
Books.find(:first, conditions: "authors.name = 'Jenny James'", joins: [:authors])


module AssertValidKeys
  def assert_valid_keys(*valid_keys)
    unknown_keys = keys - [valid_keys].flatten
    if unknown_keys.any?
      raise(ArgumentError, "Unknown key(s): #{unknown_keys.join(", ")}")
    end
  end
end
Hash.send(:include, AssertValidKeys)

class Books
  def self.find(selector, hash={})
    hash.assert_valid_keys :conditions, :joins
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
Books.find(:all, conditions: "title LIKE '%Voodoo Economics'")
Books.find(:all, conditions: "authors.name = 'Jenny James", joins: [:authors])
Books.find(:first, conditions: "authors.name = 'Jenny James'", joins: [:authors])
