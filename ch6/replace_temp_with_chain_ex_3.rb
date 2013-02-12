class Select
  def self.with_option(option)
    select = new
    select.options << option
    select
  end

  def options
    @options ||= []
  end

  def and(arg)
    options << arg
    self
  end
end


select = Select.with_option(1999).and(2000).and(2001).and(2002)
select # => #<Select:0x10676aeb0 @options=[1999, 2000, 2001, 2002]>
