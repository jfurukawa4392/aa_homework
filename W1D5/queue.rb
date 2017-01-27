class Queue

  def initialize
    @ivar = []
  end

  def enqueue(el)
    @ivar.unshift(el)
  end

  def dequeue
    @ivar.pop
  end

  def show
    @ivar.dup
  end
end

if __FILE__ == $PROGRAM_NAME
  q = Queue.new
  puts "Adding queue elements 0 to 10 inclusive"
  (0..10).each { |el| q.enqueue(el) }
  print "#{q.show} \n"
  sleep(3)
  puts "Deqeuing next element of queue"
  q.dequeue
  print "#{q.show} \n"
  sleep(3)
  puts "Deqeuing next element of queue"
  q.dequeue
  print "#{q.show} \n"
  sleep(3)
  puts "Deqeuing next element of queue"
  q.dequeue
  print "#{q.show} \n"
end
