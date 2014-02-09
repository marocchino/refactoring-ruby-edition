# before
class Person
  def self.attr_with_default(options)
    options.each_pair do |attribute, default_value|
      define_method attribute do
        eval "@#{attribute} ||= #{default_value}"
      end
    end
  end

  attr_with_default emails: "[]",
    employ_number: "EmployNumberGenerator.next"
end

# after
class Person
  def self.attr_with_default(options)
    options.each_pair do |attribute, default_value|
      eval "define_method #{attribute} do
           @#{attribute} ||= #{default_value}
           end"
    end
  end

  attr_with_default emails: "[]",
    employ_number: "EmployNumberGenerator.next"
end

