class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i.abs > @count
    if i >= 0
      @store[i]
    else
      # p i
      # p @count - i.abs
      # p i.abs
      @store[@count - i.abs]
    end
  end

  def []=(i, val)
    if i > @count
      self.push(nil)
    end
    @store[i] = val

  end

  def capacity
    @store.length
  end

  def include?(val)
    index = 0

    until index == capacity
      return true if self[index] == val
      index += 1
    end

    false
  end

  def push(val)
    resize! if @count == capacity
    self[@count] = val
    @count += 1
  end

  def unshift(val)
    @count += 1
    resize! if @count == capacity
    new_arr = StaticArray.new(capacity)
    new_arr[0] = val

    i = 1
    until i == @count
      new_arr[i] = @store[i - 1]
      i += 1
    end

    @store = new_arr
    val
  end

  def pop
    return nil if @count == 0
    last =  self.last
    @count -= 1
    self[@count] = nil
    last
  end

  def shift
    return nil if @count == 0
    first = self.first

    i = 0
    until i == count - 1
      self[i] = self[i + 1]
      i += 1
    end

    @count -= 1
    self[count] = nil
    first
  end

  def first
    self[0]
  end

  def last
    self[@count - 1]
  end

  def each
    @count.times { |i| yield self[i] }
    @store
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)

    i = 0
    until i == count
      return false if self[i] != other[i]
      i += 1
    end

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_size = capacity * 2
    new_arr = StaticArray.new(new_size)

    i = 0
    until i == @count
      new_arr[i] = @store[i]
      i += 1
    end

    @store = new_arr
  end
end
