class SearchCriteria
  def initialize(hash)
    @author_id = hash[:author_id]
    @publisher_id = hash[:publisher_id]
    @isbn = hash[:isbn]
  end
end

class SearchCriteria
  def self.hash_initializer(*attribute_names)
    define_method(:initialize) do |*args|
      data = args.first || {}
      data.symbolize_keys!
      attribute_names.each do |attribute_name|
        instance_variable_set "@#{attribute_name}", data[attribute_name]
      end
    end
  end

  hash_initializer :author_id, :publisher_id, :isbn
end


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
