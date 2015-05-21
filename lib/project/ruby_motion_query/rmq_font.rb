# many hacks in this: we can't duplicate the iOS implementation because
# define_singleton_method isn't implemented in Android :'(
class RMQ

  def self.font(*params)
    RMQFont.shared
  end

  def font(*params)
    self.class.font
  end

end

class RMQFont

  def self.shared
    @instance ||= new
  end

  def add_named(key, font_name, size)
    font_cache[key] = RMQFontStruct.new(font_name, size)
  end

  def method_missing(font_key)
    font_cache[font_key]
  end

  private

  def font_cache
    @font_cache ||= {}
  end

end

class RMQFontStruct
  attr_accessor :name
  attr_accessor :size

  def initialize(name, size)
    @name = name
    @size = size
  end
end
