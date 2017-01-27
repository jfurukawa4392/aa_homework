class Map

  def initialize
    @ivar = []
  end

  def assign(key, value)
    pair = self.lookup(key)
    if pair
      pair.pop
      pair.push(value)
    else
      @ivar.push([key, value])
    end
  end

  def lookup(key)
    @ivar.each do |pair|
      if pair.first == key
        return pair
      end
    end

    nil
  end

  def remove(key)
    @ivar.delete_if { |pair| pair.first == key }
  end

  def show
    print "#{@ivar} \n"
  end
end

if __FILE__ == $PROGRAM_NAME
  map = Map.new
  map.assign(2,1)
  map.show
  sleep(1)
  map.assign(1,2)
  map.show
  sleep(1)
  map.assign(3,3)
  map.show
  sleep(1)
  map.assign(5,1)
  map.show
  sleep(1)
  map.remove(5)
  map.show
  sleep(1)
  map.remove(1)
  map.show
  sleep(1)
  map.assign(1,10)
  map.show
end
