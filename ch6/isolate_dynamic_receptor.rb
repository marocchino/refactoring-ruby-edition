# before
class Recorder
  instance_methods.each do |method|
    undef_method method unless method =~ /^(__|inspect)/
  end

  def message
    @message ||= []
  end

  def method_missing(sym, *args)
    message << [sym, args]
    self
  end

  def play_for(obj)
    messages.inject(obj) do |result, message|
      result.send message.first, *message.last
    end
  end

  def to_s
    messages.inject([]) do |result, message|
      result << "#{message.first}(args: #{message.last.inspect}"
    end.join("")
  end
end

class CommandCenter
  def start(command_string)
    # ...
    self
  end

  def stop(command_string)
    # ...
    self
  end
end

recorder = Recorder.new
recorder.start("LRMMMMRL")
recorder.stop("LRMMMMRL")
recorder.play_for(CommandCenter.new)


# after
class MessageCollector
  instance_methods.each do |method|
    undef_method method unless method =~ /^(__|inspect)/
  end

  def message
    @message ||= []
  end

  def method_missing(sym, *args)
    message << [sym, args]
    self
  end
end

class Recorder
  def play_for(obj)
    @message_collocter.messages.inject(obj) do |result, message|
      result.send message.first, *message.last
    end
  end

  def record
    @message_collocter ||= MessageCollector.new
  end

  def to_s
    @message_collocter.messages.inject([]) do |result, message|
      result << "#{message.first}(args: #{message.last.inspect}"
    end.join("")
  end
end

recorder = Recorder.new
recorder.record.start("LRMMMMRL")
recorder.record.stop("LRMMMMRL")
recorder.play_for(CommandCenter.new)
