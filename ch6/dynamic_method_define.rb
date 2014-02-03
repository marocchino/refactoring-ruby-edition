# before
def failure
  self.state = :failure
end

def error
  self.state = :error
end

def success
  self.state = :success
end

# after 1-1
[:failure, :error, :success].each do |method_name|
  define_method method_name do
    self.state = method_name
  end
end

# after 1-2
class Class
  def def_each(*method_names, &block)
    method_names.each do |method_name|
      define_method method_name do
        instance_exec method_name, &block
      end
    end
  end
end

def_each :failure, :error do |method_name|
  self.state = method_name
end

# after 2
class Post
  def self.states(*args)
    args.each do |arg|
      define_method arg do
        self.state = arg
      end
    end
  end

  states :failure, :error, :success
end

# before
class PostData
  def initialize(post_data)
    @post_data = post_data
  end

  def params
    @post_data[:params]
  end

  def session
    @post_data[:session]
  end
end

# after 1
class PostData
  def initialize(post_data)
    (class << self; self; end).class_eval do
      post_data.each_pair do |key, value|
        define_method key.to_sym do
          value
        end
      end
    end
  end
end

# after 2
class Hash
  def to_module
    hash = self
    Module.new do
      hash.each do |key, value|
        define_method key do
          value
        end
      end
    end
  end
end

class PostData
  def initialize(post_data)
    self.extend post_data.to_module
  end
end
