module Enumerable
  def my_each
    return enum_for unless block_given?
    i = 0
    new_array = self.is_a?(Range) ? self.to_a : self
    new_array = self.is_a?(Hash) ? self.to_a : self
    while i < new_array.length
      yield new_array[i]
      i += 1
    end
    new_array
  end

  def my_each_with_index
    return enum_for unless block_given?
    i = 0
    # new_array = self.is_a?(Range) ? self.to_a : self
    new_array = self.is_a?(Hash) ? self.to_a : self
    while i < new_array.length
      yield new_array[i], i
      i += 1
    end
    new_array
  end

  def my_select
    new_numbers = []
    each do |i|
      new_numbers.push(i) if yield(i)
    end
    new_numbers
  end

  def my_all?
    condition = true
    each do |j|
      condition = false unless yield(j)
    end
    condition
  end

  def my_any?
    each do |j|
      return true if yield(j)
    end
    false
  end

  def my_none?
    condition = true
    each do |j|
      condition = false if yield(j)
    end
    condition
  end

  def my_count(counted)
    counting = 0
    each do |j|
      counting += 1 if j == counted
    end
    counting
  end

  def my_map(proc = nil)
    arr = []
    each do |i|
      if !proc.nil?
        arr.push(proc.call(i))
      else
        arr.push(yield i)
      end
    end
    arr
  end

  def my_inject(arg = nil)
    product = 0
    i = 0
    while i < length
      product = yield product, self[i]
      if product.zero?
        product = 1
        product = yield product, self[i]
      end
      i += 1
    end
    product = yield product, arg unless arg.nil?
    product
  end
end

def multiply_els(arr)
  arr.my_inject { |product, n| product * n }
end


# puts (1..5).my_each { |num| num < 6}
# test = {"a" => 1, "b" => 2, "c" => 3}
# test.my_each{|key, value| puts "#{key}, #{value}" } 

# p [1,2,3,4,5].my_each_with_index { |num| num < 6}
# # p (1..5).my_each_with_index { |num| num < 6}
# (1..5).my_each_with_index { |num, i| puts "Num: #{num}, index: #{i}"}

test = {"a" => 1, "b" => 2, "c" => 3}
test.my_each_with_index {|num, i| puts "#{num}, #{i}" } 