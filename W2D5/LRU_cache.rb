class LRUCache
  def initialize(size)
    @size = size
    @cache = []
  end

  def count
    # returns number of elements currently in cache
    @cache.length
  end

  def add(el)
    # adds element to cache according to LRU principle
    idx = @cache.index(el)
    if idx.nil?
      #not there
      @cache.unshift(el)
      trash_last if full?
    else
      #element is there already
      @cache = @cache[0...idx] + @cache[(idx + 1)..-1]
      @cache.unshift(el)
    end
  end

  def show
    # shows the items in the cache, with the LRU item first
    @cache.each { |el| print "#{el} " }
  end

  private
  # helper methods go here!
  def full?
    @cache.length > @size
  end

  def trash_last
    @cache = @cache[0..-2]
  end
end

if __FILE__ == $PROGRAM_NAME
  johnny_cache = LRUCache.new(4)

  johnny_cache.add("I walk the line")
  johnny_cache.add(5)

  johnny_cache.count # => returns 2

  johnny_cache.add([1,2,3])
  johnny_cache.add(5)
  johnny_cache.add(-5)
  johnny_cache.add({a: 1, b: 2, c: 3})
  johnny_cache.add([1,2,3,4])
  johnny_cache.add("I walk the line")
  johnny_cache.add(:ring_of_fire)
  johnny_cache.add("I walk the line")
  johnny_cache.add({a: 1, b: 2, c: 3})
end
