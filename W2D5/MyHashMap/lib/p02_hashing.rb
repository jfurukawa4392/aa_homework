class Fixnum
  # Fixnum#hash already implemented for you
end

# class Array
#   def hash
#     key = 13
#     total = 0
#
#     each_with_index do |el, idx|
#       total += (el + idx) ^ key
#     end
#
#     total ^ key
#   end
# end
#
# class String
#   def hash
#     chars.map(&:ord).hash
#   end
# end
#
# class Hash
#   # This returns 0 because rspec will break if it returns nil
#   # Make sure to implement an actual Hash#hash method
#   def hash
#     values.sort.map(&:to_s).map(&:to_i).hash
#     # 0
#   end
# end

class Array
  def hash
    each_with_index.inject(0) do |intermediate_hash, (el, i)|
      (el.hash + i.hash) ^ intermediate_hash
    end
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  def hash
    to_a.sort_by(&:hash).hash
  end
end
