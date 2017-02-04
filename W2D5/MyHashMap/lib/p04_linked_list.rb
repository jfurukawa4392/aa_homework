class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next unless @prev.nil?
    @next.prev = @prev unless @next.nil?
    self
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = nil
    @tail = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.nil?
  end

  def get(key)
    link = @head

    until link.nil? || link.key == key
      link = link.next
    end

    link.nil? ? nil : link.val
  end

  def include?(key)
    link = @head

    until link.nil?
      return true if link.key == key
      link = link.next
    end

    false
  end

  def append(key, val)
    link = Link.new(key, val)

    if empty?
      @head = link
      @tail = link
    else
      link.prev = @tail
      @tail.next = link
      @tail = link
    end

    link
  end

  def update(key, val)
    link = @head

    until link == @tail || link.key == key
      link = link.next
    end

    link.val = val unless link.nil?
  end

  def remove(key)
    link = @head

    until link == @tail || link.key == key
      link = link.next
    end

    @head = link.next if @head == link
    @tail = link.prev if @tail == link

    link.nil? ? nil : link.remove
  end

  def each
    link = @head

    until link.nil?
      yield link
      link = link.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
